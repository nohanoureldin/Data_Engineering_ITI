# Unit test: Smallest Part
# Function - Method - Class - Module
# The AAA Testing Model
# Arrange: Prepare data and environment (Test Cases + Edge Cases)
# Scenario => Test Cases
# Normal Value
# Zero Values (1st Edge Case)
# Negative Values (2nd Edge Case)
# Large Values (3rd Edge Case)


# Test Case       => Inputs                   => Expected Result
# Case 1          => add(1,2)                 => 3
# Case 2          => add(0,0)                 => 0
# Case 3          => add(1,-5)                => -4
# Case 4          => add(1000000,5000000)     => 6000000


# Act: Execute the original/source function => Actual Result
# Assert: Verify the result is correct


def add(a: int,b: int) -> int:
    return a + b

# Act: Execute the original/source function => Actual Result
# actual_result = add(1,2)

# expected_result = 3

# Assert: Verify the result is correct
# print(actual_result == expected_result)


def divide(a: int, b: int) -> int:
    return a/b


# Project Setup:
# Python Installation
# Verify Installation: Terminal: python --version
# Install Package Globally:
# Terminal: pip install pytest
# Verify pytest Command:
# Terminal: pytest --version


# pytest
# check all files in the root directory
# run specific files start with test_ or ends with _test

# Naming Convention/Rule + Strict Rules to use unittest: 
# Test file must start/begin with test_ or ends with _test
    # pytest automatically detect file named: test_*.py or *_test.py
# Test Methods start/begin with test_
    # pytest automatically detect functions named: test_*



# @ Decorator: Special python syntax (class/function✅) used to add metadata or
# Modify behavior of another function without changing source code

# def greet():
#     print("Hello World")

# def my_decorator(original_function):
#     def wrapper():
#         print("Before original_function execution")
#         original_function()
#         print("After original_function execution")
#     return wrapper


# # decorated_function = my_decorator(greet)
# # decorated_function()

# # Shortcut syntax using Python
# @my_decorator
# def say_hello():
#     print("Hello")

# say_hello()

def is_superuser(api_data):
    return api_data["role"] == "superuser"

def get_username(database, user_id):
    user = database.get_user(user_id)
    return user["name"]
