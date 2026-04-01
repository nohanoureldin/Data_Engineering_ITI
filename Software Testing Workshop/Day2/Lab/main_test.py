import pytest
from unittest.mock import Mock
from main import BankAccount


@pytest.fixture
def account():
    mock_logger = Mock()
    bank = BankAccount(balance=100, logger=mock_logger)
    return bank


#Normal Operations

def test_deposit(account):
    result = account.deposit(50)
    assert result == 150
    account.logger.log.assert_called_with("Deposited 50")


def test_withdraw(account):
    result = account.withdraw(30)
    assert result == 70
    account.logger.log.assert_called_with("Withdrew 30")


#Edge Cases

def test_deposit_zero(account):
    result = account.deposit(0)
    assert result == 100
    account.logger.log.assert_called_with("Deposited 0")


def test_withdraw_full_balance(account):
    result = account.withdraw(100)
    assert result == 0
    account.logger.log.assert_called_with("Withdrew 100")


#Exception / Error Handling

def test_withdraw_insufficient_funds(account):
    with pytest.raises(ValueError, match="Insufficient funds"):
        account.withdraw(200)
    account.logger.log.assert_called_with("Failed withdrawal of 200")
