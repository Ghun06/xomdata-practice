# Xom Data · Second largest value
# Problem: https://xomdata.com/practice/py-second-largest
# Solved: 2026-09-03

def second_largest(numbers):
    unique = set(numbers)
    if len(unique) < 2:
        return None
    unique.remove(max(unique))
    return max(unique)
