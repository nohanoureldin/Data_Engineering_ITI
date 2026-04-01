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


# Test Suit: Group of related test cases


# DRY: Don't Repeat Yourself
from main import add, divide
import pytest


# def test_add():
#     # Act: Execute the original/source function => Actual Result
#     actual_result = add(1,2) # Arguments => Arranged Data
#     expected_result = 3

#     # Assert: Verify the result is correct 
#     # => Comparison Actual Result = Expected Result
#     assert actual_result == expected_result


# def test_divide():
#     actual_result = divide(10, 2)
#     expected_result = 5
#     assert actual_result == expected_result



# Run one/more Test files
# Terminal: pytest

# Status Code:
# . (The dot) => Passed
# F           => Failed

# pluggy: plugin management system


# ******************** The Output in case of Passed: ********************
# ====================== test session starts ======================
# platform win32 -- Python 3.14.3, pytest-9.0.2, pluggy-1.6.0
# rootdir: E:\desktop-projects\zagazig-de46r2-testing
# plugins: anyio-4.12.1
# collected 2 items                                                                          

# main_test.py ..                                              [100%] 

# ====================== 2 passed in 0.05s ====================== 



# ******************** The Output in case of Failure: ********************
# ====================== test session starts ======================
# platform win32 -- Python 3.14.3, pytest-9.0.2, pluggy-1.6.0
# rootdir: E:\desktop-projects\zagazig-de46r2-testing
# plugins: anyio-4.12.1
# collected 2 items                                                                                          

# main_test.py .F                [100%]

# ====================== FAILURES ====================== 
# _______________________ test_divide _______________________ 

#     def test_divide():
#         actual_result = divide(10, 2)
#         expected_result = 0
# >       assert actual_result == expected_result
# E       assert 5.0 == 0

# main_test.py:33: AssertionError
# ====================== short test summary info ====================== 
# FAILED main_test.py::test_divide - assert 5.0 == 0
# ====================== 1 failed, 1 passed in 0.14s ======================



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


# Parameterization: Running same test multiple time with different inputs (using built-in decorator)
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

# a       , b       , expected
# 1       , 2       , 3
# 0       , 0       , 0
# 1       , -5      , -4
# 1000000 , 5000000 , 6000000


# @pytest.mark.parametrize(names_of_parameters_as_string, [ tuples(arranged data) ])

@pytest.mark.parametrize(
    "a,b,expected",
    [
        (1       , 2       , 3),
        (0       , 0       , 0),
        (1       , -5      , -4),
        (1000000 , 5000000 , 6000000),
    ]
)
def test_add(a,b,expected):
    # Act: Execute the original/source function => Actual Result
    actual_result = add(a,b) # Arguments => Arranged Data
    expected_result = expected

    # Assert: Verify the result is correct 
    # => Comparison Actual Result = Expected Result
    assert actual_result == expected_result





# Arrange:
# Test Case       => Inputs                   => Expected Result
# Case 1          => divide(10,2)             => 5
# Case 2          => divide(0,0)              => error ❌
# Case 3          => divide(10,-5)            => -2
# Case 4          => divide(5000000,1000000)  => 5

# a       , b       , expected
# 10      , 2       , 5
# 0       , 0       , error ❌
# 10      , -5      , -2
# 5000000 , 1000000 , 5


@pytest.mark.parametrize(
  "a,b,expected", [
    (10      , 2       , 5),
    (10      , -5      , -2),
    (5000000 , 1000000 , 5),
  ]
)
def test_divide(a,b,expected):
    actual_result = divide(a,b)
    expected_result = expected
    assert actual_result == expected_result



def test_divide_by_zero():
    with pytest.raises(ZeroDivisionError):
        divide(10,0)



# Dependency Injection

# Tightly Coupled before injection
# class Battery:
#     def power(self):
#         return "Device Powered"

# class Toy:
#     def __init__(self):
#         self.battery = Battery() # Tightly Coupled
    
#     def work(self):
#         print("Toy Works")

# To Decouple (use injection)
# class Battery:
#     def power(self):
#         return "Device Powered"

# class Toy:
#     def __init__(self, battery):    # Dependency Injection
#         self.battery = battery      # Decoupling
    
#     def work(self):
#         print("Toy Works")

# class Varta(Battery):
#     pass

# class Energizer(Battery):
#     pass

# class Sony(Battery):
#     pass

# varta = Varta()
# energizer = Energizer()
# sony = Sony()

# fish_toy1 = Toy(varta)
# fish_toy2 = Toy(energizer)
# fish_toy3 = Toy(energizer)




# 1st case of Dependency
# Function run first => return Results
# The tested function depend on these Results

# =>>>>>>>>>>> To Complete Test Must eliminate any Dependencies
# Create Fixture => Prepare the environment required for test
# Fixture doesn't have any logic
# Only return the data needed simulating the same result of the original dependency
from main import is_superuser

@pytest.fixture
def sample_user():
    return {"id":1, "username":"Alyaa", "role": "superuser"}

# def is_superuser(api_data):
#     return api_data.role == "superuser"

def test_is_superuser(sample_user):
    actual_result = is_superuser(sample_user)
    expected_result = True
    assert actual_result == expected_result


# def get_user_data():
#     return database.query("SELECT * FROM users")

# Mocking: Simulation
# Mock: Fake object that simulate a real object

# Real System:       function => database => result
# Testing System:    function => fake database => predefined results


# Real data: { "id":1, "name": "Omar"}

# fake object creator
from unittest.mock import Mock
from main import get_username 

# def get_username(database, user_id):
#     user = database.get_user(user_id)
#     return user["name"]


def test_get_username():
    mock_database = Mock()
    # Define Mock Behavior
    mock_database.get_user.return_value = {"name": "Omar"}

    # Act
    actual_result = get_username(mock_database, 1)

    expected_result = "Omar"

    # Assert
    assert actual_result == expected_result



# Code Coverage:
# pip install coverage