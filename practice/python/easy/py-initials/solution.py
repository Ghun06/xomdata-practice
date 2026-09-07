# Xom Data · Generate initials
# Problem: https://xomdata.com/practice/py-initials
# Solved: 2026-09-07

def get_initials(full_name):
    words = full_name.split()
    initials = ""

    for word in words:
        initials += word[0].upper()

    return initials
