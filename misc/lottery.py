import random

# Define a list of the most frequent numbers in the Israeli lottery
most_frequent_numbers = [5, 7, 14, 19, 21, 26, 30, 32, 36, 10]

# Generate 6 random numbers from 1 to 37
numbers = random.sample(range(1, 38), 6)

# Choose a "strong" number between 1 to 7
strong_number = random.randint(1, 7)

# Check if the "strong" number is also one of the most frequent numbers
# If so, choose another random number until a unique number is found
while strong_number in most_frequent_numbers:
    strong_number = random.randint(1, 7)

# Print the results
print("Numbers: ", sorted(numbers))
print("Strong number: ", strong_number)
