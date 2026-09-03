# Xom Data · Compute price after discount
# Problem: https://xomdata.com/practice/py-discount
# Solved: 2026-09-03

def final_price(price, percent):
    price = round((price - price * percent / 100), 2)
    return price
