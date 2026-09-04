# Xom Data · Greatest common divisor
# Problem: https://xomdata.com/practice/py-gcd
# Solved: 2026-09-04

def gcd(a, b):
    while b:
        a, b = b, a % b
    return a
