# Web Server Benchmark

This script benchmarks web servers using random characters in the URL. It supports GET, POST, and HEAD HTTP methods, and allows you to specify the number of requests, threads, and an optional proxy.

## Requirements

- Python 3.x
- requests
- tqdm

## Installation

1. Clone this repository:

```
git clone 
cd web_benchmark
```

2. Install the required Python packages:

```
pip install -r requirements.txt
```

3. Run the script with the desired options:

```
python benchmark.py https://example.com -m get -r 100
```

## Usage

```
usage: benchmark.py [-h] [-m METHOD] [-r REQUESTS] [-t THREADS] [-p PROXY] url

Benchmark web servers using random characters in the URL.

positional arguments:
  url                   The target URL.

optional arguments:
  -h, --help            show this help message and exit
  -m METHOD, --method METHOD
                        The HTTP method to use (get, post, or head). Default: get.
  -r REQUESTS, --requests REQUESTS
                        The number of requests to make (default: 100).
  -t THREADS, --threads THREADS
                        The number of threads to use for requests (default: 10).
  -p PROXY, --proxy PROXY
                        Optional proxy to use for requests.

Example: python benchmark.py https://example.com -m get -r 100 -t 20 --proxy http://proxy.example.com:8080
```
```
