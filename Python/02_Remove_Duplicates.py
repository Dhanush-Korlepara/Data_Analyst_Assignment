def remove_duplicates(s):
    result = ""

    for char in s:
        if char not in result:
            result += char

    return result


# Example usage
print(remove_duplicates("programming"))  # progamin