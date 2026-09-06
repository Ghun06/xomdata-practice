# Xom Data · Count vowels in a name
# Problem: https://xomdata.com/practice/py-vowels
# Solved: 2026-09-06

def count_vowels(name):
    count = 0

    for char in name.lower():
        if char in "aeiou":
            count += 1

    return count
