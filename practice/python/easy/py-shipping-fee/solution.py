# Xom Data · Shipping fee by weight bracket
# Problem: https://xomdata.com/practice/py-shipping-fee
# Solved: 2026-09-03

def shipping_fee(weight):
    if weight <= 1:
        fee = 15000
    elif weight > 5:
        fee = 50000
    else:
        fee = 30000
    
    return fee
