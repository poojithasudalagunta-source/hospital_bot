from flask import Flask, jsonify, request, render_template, session
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from flask_cors import CORS

app = Flask(__name__)
app.secret_key = "mediquery_secret"
CORS(app)

# ---------------- DATABASE CONFIG ----------------
DB_USER = "flaskuser"
DB_PASSWORD = "flask123"
DB_HOST = "127.0.0.1"
DB_NAME = "mediquary_ai"

app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# ---------------- BASIC ROUTES ----------------
@app.route("/")
def home():
    return "MediQuery AI Backend Running"

@app.route("/ui")
def ui():
    return render_template("index.html")


# ---------------- STANDARD RESPONSE ----------------
def response(type_, reply, data=None):
    return jsonify({
        "type": type_,
        "reply": reply,
        "data": data if data else []
    })


# ================= CHATBOT =================
@app.route("/chat", methods=["POST"])
def chat():
    try:
        data = request.get_json(force=True)
        msg = data.get("message", "").lower().strip()
        patient_id = data.get("patient_id", 1)

        # -------- GLOBAL RESET --------
        reset_words = ["hi", "hello", "hey", "restart", "menu", "home", "cancel"]
        if msg in reset_words:
            session.clear()
            session["state"] = "start"
            return response("welcome",
                "Hello 👋 I'm MediQuery Assistant.\n"
                "You can tell me your symptoms and I will help you book an appointment."
            )

        state = session.get("state", "start")

        # =====================================================
        # SYMPTOM TRIAGE
        # =====================================================
        symptoms = ["pain", "fever", "vomit", "head", "chest", "leg", "back", "stomach"]

        if any(word in msg for word in symptoms):
            session["state"] = "recommend"

            if "chest" in msg or "heart" in msg:
                session["spec"] = "cardio"
                return response("triage",
                    "⚠ You may need a Cardiologist.\nShould I show available doctors? (yes/no)")

            elif "head" in msg:
                session["spec"] = "neuro"
                return response("triage",
                    "You may need a Neurologist.\nShow doctors?")

            elif "stomach" in msg:
                session["spec"] = "gastro"
                return response("triage",
                    "You may need a Gastroenterologist.\nShow doctors?")

            else:
                session["spec"] = "general"
                return response("triage",
                    "You may consult a General Physician.\nShow doctors?")

        # =====================================================
        # SHOW DOCTORS
        # =====================================================
        if state == "recommend" and msg in ["yes", "show", "show doctors", "ok"]:
            spec = session.get("spec", "general")

            result = db.session.execute(text("""
                SELECT d.doctor_id, u.name, d.specialization
                FROM doctors d
                JOIN users u ON u.user_id=d.user_id
                WHERE LOWER(d.specialization) LIKE :sp
            """), {"sp": f"%{spec}%"}).fetchall()

            if not result:
                session.clear()
                return response("chat", "No doctors available right now.")

            doctors = []
            doctor_map = {}

            for r in result:
                doctors.append(f"{r.name} ({r.specialization})")
                doctor_map[r.name.lower()] = r.doctor_id

            session["doctor_map"] = doctor_map
            session["state"] = "choose_doctor"

            return response("doctor_list", "Select a doctor by typing name:", doctors)

        # =====================================================
        # SELECT DOCTOR
        # =====================================================
        if state == "choose_doctor":
            doctor_map = session.get("doctor_map", {})

            selected_id = None
            for name in doctor_map:
                if name in msg:
                    selected_id = doctor_map[name]
                    session["doctor_id"] = selected_id
                    break

            if not selected_id:
                return response("chat", "Please type the doctor name exactly from list.")

            slots = db.session.execute(text("""
                SELECT slot_id, appointment_date, slot_time
                FROM appointment_slots
                WHERE doctor_id=:did AND status='free'
                ORDER BY appointment_date, slot_time
                LIMIT 5
            """), {"did": selected_id}).fetchall()

            if not slots:
                session.clear()
                return response("chat", "No free slots for this doctor. Try another symptom.")

            slot_map = {}
            times = []

            for s in slots:
                label = f"{s.appointment_date} {s.slot_time}"
                times.append(label)
                slot_map[label.lower()] = s.slot_id

            session["slots"] = slot_map
            session["state"] = "choose_time"

            return response("slots", "Choose a time slot:", times)

        # =====================================================
        # SELECT TIME
        # =====================================================
        if state == "choose_time":
            slot_map = session.get("slots", {})

            selected_slot = None
            for t in slot_map:
                if t in msg:
                    selected_slot = slot_map[t]
                    break

            if not selected_slot:
                return response("chat", "Please type a valid time exactly from the list.")

            slot = db.session.execute(text("""
                SELECT doctor_id, appointment_date, slot_time
                FROM appointment_slots
                WHERE slot_id=:sid
            """), {"sid": selected_slot}).fetchone()

            did, date, time = slot

            db.session.execute(text("""
                INSERT INTO appointments
                (patient_id, doctor_id, appointment_date, appointment_time, status)
                VALUES (:pid,:did,:dt,:tm,'requested')
            """), {"pid": patient_id, "did": did, "dt": date, "tm": time})

            db.session.execute(text("""
                UPDATE appointment_slots
                SET status='occupied', patient_id=:pid
                WHERE slot_id=:sid
            """), {"pid": patient_id, "sid": selected_slot})

            db.session.commit()
            session.clear()

            return response("success", f"✅ Appointment booked on {date} at {time}")

        # =====================================================
        # FALLBACK
        # =====================================================
        return response("chat", "Please describe your symptom (example: 'I have headache').")

    except Exception as e:
        session.clear()
        return response("error", str(e))


# ---------------- RUN SERVER ----------------
if __name__ == "__main__":
    app.run(debug=True)