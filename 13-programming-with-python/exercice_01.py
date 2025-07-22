my_list = [1, 2, 2, 4, 4, 5, 6, 8, 10, 13, 22, 35, 52, 83]

print("Printing numbers greater than or equal to 10:")
for e in my_list:
    if e >= 10:
        print(e)

print("List of numbers greater than or equal to 10:")
ge10 = [e for e in my_list if e >= 10]
print(ge10)

print("List of numbers greater than or equal to user input:")
user_input = int(input("Enter a number: "))
ge_user_input = [e for e in my_list if e >= user_input]
print(ge_user_input)
