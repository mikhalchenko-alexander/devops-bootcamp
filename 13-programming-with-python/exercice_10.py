import requests

response = requests.get("https://api.github.com/users/mikhalchenko-alexander/repos")
json = response.json()
for repo in json:
    print(f"{repo['name']} - {repo['url']}")
