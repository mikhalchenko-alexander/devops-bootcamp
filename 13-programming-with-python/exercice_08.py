import datetime

user_birthday_input = input("Enter your birthday (dd/mm/yyyy): ")

user_birthday = datetime.datetime.strptime(user_birthday_input, "%d/%m/%Y")
now = datetime.datetime.now()

if user_birthday.month > now.month or user_birthday.month == now.month and user_birthday.day > now.day:
    next_birthday = user_birthday.replace(year=now.year)
else:
    next_birthday = user_birthday.replace(year=now.year + 1)

until_next_birthday = next_birthday - now
seconds_until_next_birthday = until_next_birthday.seconds
days_until_next_birthday = until_next_birthday.days
hours_until_next_birthday = seconds_until_next_birthday // 3600
minutes_until_next_birthday = (seconds_until_next_birthday % 3600) // 60

print(f"You have {days_until_next_birthday} days, {hours_until_next_birthday} hours and {minutes_until_next_birthday} minutes until your next birthday.")
