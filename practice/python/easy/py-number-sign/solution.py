# Xom Data · Determine the sign of a number
# Problem: https://xomdata.com/practice/py-number-sign
# Solved: 2026-09-02

def number_sign(n):
    if n > 0:
        return 1
    elif n == 0:
        return 0
    else:
        return -1
