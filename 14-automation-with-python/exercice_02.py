import boto3

session = boto3.Session(profile_name='alex-admin')
iam_client = session.client('iam')
users = iam_client.list_users()['Users']
for user in users:
    password_last_used = user['PasswordLastUsed'] if 'PasswordLastUsed' in user else "Never"
    print(f"User {user['UserName']} last activity: {password_last_used}")

active_users = list(filter(lambda x: 'PasswordLastUsed' in x, users))
if len(active_users) > 0:
    sorted_users = sorted(active_users, key=lambda u: u['PasswordLastUsed'], reverse=True)[0]
    print(f"Most recently active user: {sorted_users['UserName']}")
else:
    print("No active users found.")
