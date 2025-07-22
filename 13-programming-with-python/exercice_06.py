import random

number_to_guess = random.randint(1, 9)

while True:
    user_guess = int(input("Enter a number between 1 and 9: "))
    if user_guess == number_to_guess:
        print("YOU WON!")
        break
    elif user_guess < number_to_guess:
        print("Too low!")
    else:
        print("Too high!")
