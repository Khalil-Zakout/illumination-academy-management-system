import re

def validate_date(date_str):
    pattern = r'^(19|20)\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$'
    return re.match(pattern, date_str)

def validate_email(email):
    pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email)

def validate_phone(phone):
    pattern = r'^\+?[0-9\s\-]{10,}$'
    return re.match(pattern, phone)
