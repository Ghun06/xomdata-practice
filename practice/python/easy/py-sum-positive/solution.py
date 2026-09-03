# Xom Data · Total receipts
# Problem: https://xomdata.com/practice/py-sum-positive
# Solved: 2026-09-03

def sum_positive(numbers):
    total = 0
    for i in numbers:
        if i > 0:
            total += i

    return total
