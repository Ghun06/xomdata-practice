# Xom Data · Highest price in the list
# Problem: https://xomdata.com/practice/py-max-price
# Solved: 2026-09-04

def highest_price(prices):
    max_price = 0
    for i in prices:
        if i > max_price:
            max_price = i

    return max_price
