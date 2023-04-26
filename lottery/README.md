
# Israeli Lottery Number Generator

This is a simple Python script that generates random numbers for the Israeli lottery. It uses a list of the most frequent numbers in the lottery, and generates a set of random numbers that do not include these frequent numbers.

## Installation

1. Clone this repository to your local machine.

## Usage

To use this script, simply run `lottery_generator.py`. The script will generate a set of 6 random numbers between 1 and 37, as well as a "strong" number between 1 and 7. If the strong number is one of the most frequent numbers in the lottery, the script will choose another random number until a unique number is found. The output will be displayed in the terminal window, and will look something like this:

```
Numbers:  [7, 14, 18, 21, 26, 34]
Strong number:  3
```

## Contributing

If you would like to contribute to this project, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
