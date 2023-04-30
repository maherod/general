#!/usr/bin/env python3
import random

# Define a list of the most frequent numbers in the Israeli lottery
most_frequent_numbers = [5, 7, 14, 19, 21, 26, 30, 32, 36, 10]

# Ask user for the number of times to generate the numbers
num_attempts = int(input("How many times do you want to generate the numbers? "))

# Generate the numbers and present the results for each attempt
for i in range(num_attempts):
    # Generate 6 random numbers from 1 to 37
    numbers = sorted(random.sample(range(1, 38), 6))

    # Choose a "strong" number between 1 to 7
    strong_number = random.randint(1, 7)

    # Check if the "strong" number is also one of the most frequent numbers
    # If so, choose another random number until a unique number is found
    while strong_number in most_frequent_numbers:
        strong_number = random.randint(1, 7)

    # Print the results
    print(f"Attempt {i+1}:")
    print(f"Numbers: {numbers}")
    print(f"Strong number: {strong_number}\n")
