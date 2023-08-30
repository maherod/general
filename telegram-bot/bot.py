#!/bin/env python3

import telebot
import os
import logging

BOT_TOKEN = os.environ.get("BOT_TOKEN")
bot = telebot.TeleBot(BOT_TOKEN)

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch = logging.StreamHandler()
ch.setFormatter(formatter)
logger.addHandler(ch)

@bot.message_handler(commands=['start', 'hello'])
def send_welcome(message):
    bot.reply_to(message, "Howdy, how are you doing?")

@bot.message_handler(commands=['info'])
def send_info(message):
    bot.reply_to(message, "I am a bot, my master is Maher Odeh")

@bot.message_handler(commands=['cmd'])
def execute_command(message):
    chat_id = message.chat.id
    command = message.text.split()[1:]
    command_str = ' '.join(command)
    try:
        output = os.popen(command_str).read()
        bot.send_message(chat_id, output)
    except OSError as e:
        logger.error(f"Failed to execute command '{command_str}': {e}")
        bot.send_message(chat_id, "Failed to execute command")
    except Exception as e:
        logger.error(f"An error occurred while executing command '{command_str}': {e}")
        bot.send_message(chat_id, "An error occurred while executing command")

if __name__ == '__main__':
    logger.info("Bot started")
    bot.polling(none_stop=True)
