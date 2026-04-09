def remove_duplicates(input_string):
    result = ""
    for char in input_string:
        if char not in result:
            result += char
    return result


# test it out
test_strings = [
    "programming",
    "hello world",
    "aabbccdd",
    "abcabc",
    "data analysis"
]

for s in test_strings:
    print(f"Input:  {s}")
    print(f"Output: {remove_duplicates(s)}")
    print()