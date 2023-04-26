# Random Parameter Generator for Caching Testing

This script generates random parameters to test a website's caching capabilities. It sends HTTP requests with a specified method (GET, POST, or HEAD) to the provided endpoint, using a random parameter as part of the URL.

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
