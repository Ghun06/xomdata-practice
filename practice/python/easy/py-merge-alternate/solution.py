# Xom Data · Alternate-merge two lists
# Problem: https://xomdata.com/practice/py-merge-alternate
# Solved: 2026-09-03

def merge_alternate(list1, list2):
    result = []
    i = 0

    while i < len(list1) or i < len(list2):
        if i < len(list1):
            result.append(list1[i])

        if i < len(list2):
            result.append(list2[i])

        i += 1

    return result
