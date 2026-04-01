class AuditLogger:
    def log(self, message):
        print(f"LOG: {message}")

class BankAccount:
    def __init__(self, balance=0, logger=None):
        self.balance = balance
        self.logger = logger

    def deposit(self, amount):
        self.balance += amount
        if self.logger:
            self.logger.log(f"Deposited {amount}")
        return self.balance

    def withdraw(self, amount):
        if amount > self.balance:
            if self.logger:
                self.logger.log(f"Failed withdrawal of {amount}")
            raise ValueError("Insufficient funds")
        self.balance -= amount
        if self.logger:
            self.logger.log(f"Withdrew {amount}")
        return self.balance