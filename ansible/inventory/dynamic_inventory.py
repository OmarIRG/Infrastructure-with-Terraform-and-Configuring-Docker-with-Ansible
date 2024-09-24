#!/usr/bin/env python3
import json
import subprocess
import os

def get_terraform_output():
    # Change to the terraform directory to get the correct output
    os.chdir('../terraform')
    result = subprocess.run(["terraform", "output", "-json"], capture_output=True, text=True)
    return json.loads(result.stdout)

def main():
    data = get_terraform_output()
    
    inventory = {
        "private": {
            "hosts": data.get("private_instance_ips", {}).get("value", [])
        }
    }
    
    print(json.dumps(inventory, indent=4))

if __name__ == "__main__":
    main()
