def print_youngest_employee(employees):
    youngest_employee = employees[0]
    for employee in employees:
        if employee["age"] < youngest_employee["age"]:
            youngest_employee = employee
    print(f"Name: {youngest_employee['name']}, Age: {youngest_employee['age']}")

def count_uppercase_lowecase_letters(text):
    uppercase_letters = 0
    lowercase_letters = 0
    for letter in text:
        if letter.isupper():
            uppercase_letters += 1
        elif letter.islower():
            lowercase_letters += 1
    return uppercase_letters, lowercase_letters

def print_even_numbers(numbers):
    even_numbers = []
    for number in numbers:
        if number % 2 == 0:
            even_numbers.append(number)
    print(f"Even numbers: {even_numbers}")
