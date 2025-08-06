import requests
from os import environ as env

HOST = env.get('HOST')
PORT = env.get('PORT')

try:
    response = requests.get(f'http://{HOST}:{PORT}')
    if response.status_code == 200:
        print('Application is running successfully!')
    else:
        print('Application deployment was not successful')
except Exception as ex:
    print(f'Connection error happened: {ex}')
    print('Application not accessible at all')

