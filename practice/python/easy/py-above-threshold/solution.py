# Xom Data · Count students above the benchmark
# Problem: https://xomdata.com/practice/py-above-threshold
# Solved: 2026-09-03

def count_above(numbers, threshold):
    j = 0
    for i in numbers:
        if i > threshold:
            j += 1
    
    return j
