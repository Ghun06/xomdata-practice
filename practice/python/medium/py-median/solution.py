# Xom Data · Median of a list
# Problem: https://xomdata.com/practice/py-median
# Solved: 2026-09-03

def median(numbers):
    nums = sorted(numbers)
    n = len(nums)
    mid = n // 2
    if n % 2 == 1:
        return nums[mid]
    else:
        return round((nums[mid - 1] + nums[mid]) / 2, 2)
