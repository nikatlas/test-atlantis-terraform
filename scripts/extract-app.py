import sys

from constants import App, Env


if len(sys.argv) < 2:
    print("You need to provide a string to extract app from")
    exit(2)

test_string = sys.argv[1]
app_name = ''
for app in App.values():
    if app in test_string:
        app_name = app
        break

env_name = ''
for env in Env.values():
    if env in test_string:
        env_name = env
        break

if not app_name or not env_name:
    exit(1)

print(f"{app_name}-{env_name}")
