# Telegram Bot

This is a simple Telegram bot that can execute shell commands and send the output back to the user.

## Prerequisites

- Python 3.9
- pip

## Requirements
- telebot==0.0.4-
- requests==2.26.0
- pyTelegramBotAPI


## Installation

1. Clone this repository
2. Install the required packages: `pip install -r requirements.txt`
3. Set the `BOT_TOKEN` environment variable to your Telegram bot token: `export BOT_TOKEN=<your_bot_token>`

## Usage

To start the bot, run the following command: `python bot.py`

Once the bot is running, you can interact with it in a Telegram chat. Send the following command to the bot to execute a shell command: `/cmd <command>`

Replace `<command>` with the shell command you want to execute. The bot will execute the command and send the output back to you.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

