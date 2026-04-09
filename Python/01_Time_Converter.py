def convert_minutes(minutes):
    hours = minutes // 60
    mins = minutes % 60

    if hours > 0:
        return f"{hours} hr{'s' if hours > 1 else ''} {mins} minutes"
    else:
        return f"{mins} minutes"


# Example usage
print(convert_minutes(130))  # 2 hrs 10 minutes
print(convert_minutes(110))  # 1 hr 50 minutes