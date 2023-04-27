# Random Parameter Generator for Caching Testing

This is a Bash script that generates random parameters and sends HTTP requests to a specified endpoint with a specified method (GET, POST, or HEAD) using cURL. It is designed to test the caching capabilities of a website by utilizing a large number of random parameters.

The script starts by defining some variables such as the user agent, IP address, and output file name. It then defines some color codes and functions for generating parameters and sending HTTP requests. The `gen_params` function generates random parameters and writes them to a file, while the `send_requests` function sends HTTP requests to the specified endpoint with the specified method.

In the main script, the user is prompted to enter the fully qualified domain name (FQDN), base URI, number of requests, and HTTP method. The script then validates the user input and calls the `send_requests` function with the specified method.

Overall, this script could be useful for testing the caching capabilities of a website and ensuring that it is functioning as expected. However, it should only be used with the website owner's permission and in a responsible manner, as excessive or unauthorized testing could lead to website downtime or other issues.


## Usage

1. Clone the repository or copy the script to your local machine.
2. Make the script executable with the command `chmod +x randurl.sh`.
3. Run the script with the command `./randurl.sh`.
4. Follow the prompts to enter the required information, including the endpoint URL, base URI, number of requests, and method (GET, POST, or HEAD).
5. The script will generate random parameters, send HTTP requests to the specified endpoint with the specified method, and display progress updates in the terminal.

## Requirements

- `curl`
- `tr`
- `fold`
- `/dev/urandom`

## License

This script is released under the [MIT License](LICENSE). Feel free to use, modify, and distribute it as you wish.
