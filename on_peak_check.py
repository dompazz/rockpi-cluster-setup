import os
import requests
import json
from datetime import datetime
import subprocess

def check_systemd_service_status(service_name):
    # Run the systemctl command to check the service status
    command = ["systemctl", "is-active", service_name]
    result = subprocess.run(command, capture_output=True, text=True)

    # Check the return code of the subprocess
    if result.returncode == 0:
        # Service is active
        return 1
    elif result.returncode == 3:
        # Service is inactive
        return 0
    else:
        # An error occurred
        return -1

def manage_systemd_service(service_name, action):
    # Validate the action parameter
    valid_actions = ['start', 'stop']
    if action not in valid_actions:
        raise ValueError(f"Invalid action '{action}'. Supported actions: {', '.join(valid_actions)}")

    # Run the systemctl command with the specified action
    command = ["systemctl", action, service_name]
    result = subprocess.run(command, capture_output=True, text=True)

    # Check the return code of the subprocess
    if result.returncode == 0:
        # Action executed successfully
        return True
    else:
        # An error occurred or action failed
        return False


url = "https://github.com/dompazz/rockpi-cluster-setup/raw/master/PeakTimes.json"  # Replace with the actual URL of your JSON file

try:
    response = requests.get(url)
    response.raise_for_status()  # Raise an exception if the request was unsuccessful
    onPeakTimes = response.json()  # Parse the JSON data from the response
    # Process the JSON data as needed
    print(onPeakTimes)
except requests.exceptions.HTTPError as err:
    print(f"HTTP error occurred: {err}")
except requests.exceptions.RequestException as err:
    print(f"An error occurred: {err}")
except json.JSONDecodeError as err:
    print(f"Failed to parse JSON: {err}")

verusStatus = check_systemd_service_status('verus')

current_time = datetime.now().time()

for peakTime in onPeakTimes["OnPeak"]:
    stTime = datetime.strptime(peakTime["Start"], '%H:%M').time()
    edTime = datetime.strptime(peakTime["End"], '%H:%M').time()
    if stTime <= current_time <= edTime:
        print(f'{current_time} - Stopping Services')
        manage_systemd_service('verus','stop')
        manage_systemd_service('gminer','stop')
    else:
        print(f'{current_time} - Starting Services')
        manage_systemd_service('verus','start')
        manage_systemd_service('gminer','start')



