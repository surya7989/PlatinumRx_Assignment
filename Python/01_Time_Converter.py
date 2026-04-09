def convert_minutes(total_minutes):
    hrs = total_minutes // 60
    mins = total_minutes % 60

    if hrs == 0:
        return f"{mins} minutes"
    elif mins == 0:
        return f"{hrs} hrs"
    else:
        return f"{hrs} hrs {mins} minutes"


# test it out
test_cases = [130, 110, 60, 45, 200, 0]

for m in test_cases:
    print(f"{m} -> {convert_minutes(m)}")