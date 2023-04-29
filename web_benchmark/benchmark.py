#!/usr/bin/env python3

import argparse
import sys
import time
import random
import string
import requests
from concurrent.futures import ThreadPoolExecutor, as_completed
from tqdm import tqdm

def random_string(length=10):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

def random_user_agent(user_agents):
    return random.choice(user_agents)

def make_request(url, method, user_agents, proxy):
    try:
        headers = {'User-Agent': random_user_agent(user_agents)}
        response = method(f"{url}/{random_string(10)}", headers=headers, proxies=proxy)
        return response.status_code
    except Exception as e:
        return None

def benchmark(url, method, requests_count, user_agents, proxy=None, num_threads=10):
    methods = {"get": requests.get, "post": requests.post, "head": requests.head}

    if method not in methods:
        print("Invalid method. Choose from 'get', 'post', or 'head'.")
        return

    request_method = methods[method]
    errors = 0
    start_time = time.time()

    with ThreadPoolExecutor(max_workers=num_threads) as executor:
        futures = [executor.submit(make_request, url, request_method, user_agents, proxy) for _ in range(requests_count)]
        for future in tqdm(as_completed(futures), total=requests_count, desc="Benchmarking", unit="requests", ncols=100):
            result = future.result()
            if result is None:
                errors += 1

    total_time = time.time() - start_time
    success_rate = (requests_count - errors) / requests_count * 100

    print(f"\nSummary:")
    print(f"URL: {url}")
    print(f"Method: {method.upper()}")
    print(f"Requests: {requests_count}")
    print(f"Errors: {errors}")
    print(f"Success rate: {success_rate:.2f}%")
    print(f"Time taken: {total_time:.2f} seconds")

def main():
    parser = argparse.ArgumentParser(description="Benchmark web servers using random characters in the URL.",
                                     epilog="Example: python benchmark.py https://example.com -m get -r 100 -t 20 --proxy http://proxy.example.com:8080")
    parser.add_argument("url", help="The target URL.")
    parser.add_argument("-m", "--method", default="get", help="The HTTP method to use (get, post, or head). Default: get.")
    parser.add_argument("-r", "--requests", type=int, default=100, help="The number of requests to make (default: 100).")
    parser.add_argument("-t", "--threads", type=int, default=10, help="The number of threads to use for requests (default: 10).")
    parser.add_argument("-p", "--proxy", help="Optional proxy to use for requests.")

    args = parser.parse_args()

    user_agents = [
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3",
        "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0"
    ]

    benchmark(url=args.url, method=args.method.lower(), requests_count=args.requests, user_agents=user_agents, proxy=args.proxy, num_threads=args.threads)

if __name__ == "__main__":
    main()
