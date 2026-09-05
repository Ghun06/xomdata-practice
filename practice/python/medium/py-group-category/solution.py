# Xom Data · Group products by category
# Problem: https://xomdata.com/practice/py-group-category
# Solved: 2026-09-05

def group_by_category(items):
    result = {}

    for name, category in items:
        if category not in result:
            result[category] = []

        result[category].append(name)

    return result
