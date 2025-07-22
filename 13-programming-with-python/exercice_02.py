employee = {
    "name": "Tim",
    "age": 30,
    "birthday": "1990-03-10",
    "job": "DevOps Engineer"
}

employee["job"] = "Software Engineer"
employee.pop("age")
for (key, value) in employee.items():
    print(f"{key}: {value}")

dict_one = {'a': 100, 'b': 400}
dict_two = {'x': 300, 'y': 200}

merged_dict = {**dict_one, **dict_two}
print(f"Merged dict: {merged_dict}")
print(f"Sum of values: {sum(merged_dict.values())}")
max_value = max(merged_dict.values())
print(f"Max value: {max_value}")
min_value = min(merged_dict.values())
print(f"Min value: {min_value}")
