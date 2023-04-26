#!/usr/bin/env python

import requests
import random
import string

# Variables
USER_AGENT = "iMacAppStore/1.0.1 (Macintosh; U; Intel Mac OS X 10.6.7; en) AppleWebKit/533.20.25"
IP_ADDRESS = "1.2.3.4"

# Colors
RED = "\033[1;31m"
YELLOW = "\033[1;33m"
GREEN = "\033[1;32m"
BOLD = "\033[1m"
RESET = "\033[0m"

# Functions
def gen_params(quantity):
    # Generates random parameters and returns them as a list
    params = []
    for i in range(quantity):
        param = ''.join(random.choices(string.ascii_letters + string.digits, k=8))
        params.append(param)
    return params

def send_requests(method, endpoint, base_uri, quantity):
    # Sends HTTP requests to the specified endpoint with the specified method
    print(f"{YELLOW}------------------------------------{RESET}")
    print(f"{BOLD}Testing {endpoint} with {method} Method")
    print(f"Total: {quantity} Requests")
    print(f"Base URI: {base_uri}")
    print(f"HIT CTRL+C to Stop\n{RESET}")
    print(f"{YELLOW}------------------------------------{RESET}")
    params = gen_params(quantity)
    count = 0
    for param in params:
        url = f"{endpoint}/{base_uri}/{param}"
        try:
            headers = {"X-Forwarded-for": IP_ADDRESS, "User-Agent": USER_AGENT}
            response = requests.request(method, url, headers=headers)
            response.raise_for_status()
        except:
            print(f"{RED}Error: Failed to send {method} request{RESET}")
            exit(1)
        count += 1
        progress = count * 100 // quantity
        print(f"Progress: [{'=' * (progress//5):20}] {progress}%\r", end="")
    print()
    print(f"{YELLOW}------------------------------------{RESET}")

# Main script
print(f"{YELLOW}-----------------------------------------------{RESET}")
print(f"{BOLD}This script generates random params to site")
print("to utilize and test its caching capabilities")
print(f"{YELLOW}-----------------------------------------------{RESET}")

# Read user input
endpoint = input("Enter FQDN: ")
base_uri = input("Base URI: ")
quantity = int(input("Number of Requests: "))
method = input("Enter GET, POST, or HEAD: ")

# Validate user input
if not endpoint:
    print(f"{YELLOW}------------------------------{RESET}")
    print(f"{RED}No Site Provided, Quitting{RESET}")
    print(f"{YELLOW}------------------------------{RESET}")
    exit(1)

if method not in ["GET", "POST", "HEAD"]:
    print(f"{YELLOW}----------------------------------{RESET}")
    print(f"{RED}Invalid Method: {method}{RESET}")
    print(f"{YELLOW}----------------------------------{RESET}")
    exit(1)

# Call the send_requests function with the specified method
send_requests(method, endpoint, base_uri, quantity)

print(f"{YELLOW}-----------------------------------------------{RESET}")
print(f"{BOLD}Finished{RESET}")
print(f"{YELLOW}-----------------------------------------------{RESET}")

