def detect_intent(text):

    text = text.lower()

    # greeting
    if any(x in text for x in ["hi","hello","hey"]):
        return "greeting"

    # symptoms
    if any(x in text for x in ["pain","fever","vomit","headache","chest","stomach","leg","back"]):
        return "symptom_check"

    # doctors
    if any(x in text for x in ["doctor","doctors","specialist","cardiologist"]):
        return "find_doctor"

    # slots
    if any(x in text for x in ["slot","time","available time","schedule"]):
        return "view_slots"

    # booking
    if any(x in text for x in ["book","appointment","consult"]):
        return "book_appointment"

    # my appointments
    if any(x in text for x in ["my appointment","appointments","history"]):
        return "my_appointments"

    # medicine
    if any(x in text for x in ["paracetamol","ibuprofen","medicine","tablet"]):
        return "medicine_info"

    return "unknown"