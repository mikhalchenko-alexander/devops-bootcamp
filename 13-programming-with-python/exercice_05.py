total_calculations = 0

while True:
    user_input = input("Enter two numbers and an operator in a form X + Y:")
    if user_input == "exit":
        break

    try:
        x, operator, y = user_input.split()
        x, y = int(x), int(y)
    except ValueError:
        print("Only numbers allowed.")
        continue

    match operator:
        case "+":
            print(x + y)
        case "-":
            print(x - y)
        case "/":
            if y == 0:
                print("Cannot divide by zero.")
                continue
            print(x / y)
        case "*":
            print(x * y)
        case _:
            print("Invalid operator.")

    total_calculations += 1

print(f"Total calculations: {total_calculations}")
