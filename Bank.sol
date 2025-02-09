// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank{
    // Struct to store account details
    struct Account {
        string name;
        uint256 accountNumber;
        uint256 balance;
        uint256 pin;
        bool exists;
    }

    // Mapping to store user accounts by account number
    mapping(uint256 => Account) public accounts;

    // Event for account creation
    event AccountCreated(uint256 accountNumber, string name);

    // Create a new account with name, account number, initial balance , and pin
    function createAccount(
        string memory _name,
        uint256 _accountNumber,
        uint256 _initialDeposit,
        uint256 _pin
        )public {
            // Ensure the account doesn't already exist
            require(!accounts[_accountNumber].exists, "Account already exists");

            // Create new account and store it in the mapping
            accounts[_accountNumber] = Account({
                name: _name,
                accountNumber: _accountNumber,
                balance: _initialDeposit,
                pin: _pin,
                exists: true
            });

            // Emit event for account creation
            emit AccountCreated(_accountNumber, _name);
        }

        // Check balance by providing account number and pin
        function checkBalance(uint256 _accountNumber, uint256 _pin) public view returns (uint256) {
            // Ensure the account exists
            require(accounts[_accountNumber].exists, "Account does not exist");

            // Ensure the provided pin matches the stored pin
            require(accounts[_accountNumber].pin == _pin, "Incorrect PIN");

            // Return the account balance
            return accounts[_accountNumber].balance;
        }
}