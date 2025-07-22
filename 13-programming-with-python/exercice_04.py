from exercise_04_module import *

employees = [{
    "name": "Tina",
    "age": 30,
    "birthday": "1990-03-10",
    "job": "DevOps Engineer",
    "address": {
        "city": "New York",
        "country": "USA"
    }
},
    {
        "name": "Tim",
        "age": 35,
        "birthday": "1985-02-21",
        "job": "Developer",
        "address": {
            "city": "Sydney",
            "country": "Australia"
        }
    }]

print_youngest_employee(employees)
print(count_uppercase_lowecase_letters("Hello World"))
print_even_numbers([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
