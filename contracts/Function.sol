// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Function {
    // Test function modifiers.
}

// Test function modifiers.
contract Owner {
    address owner;
    
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
      require(msg.sender == owner);
      _;
    }

    modifier canAfford(uint price) {
        if (msg.value >= price) {
            _;
        }
    }
}

contract Register is Owner {
    mapping(address => bool) registeredAddresses;
    uint price;
    
    constructor(uint _initialPrice) {
        price = _initialPrice;
    }

    function register() public payable canAfford(price) {
        registeredAddresses[msg.sender] = true;
    }

    function updatePrice(uint _price) public onlyOwner {
        price = _price;
    }
}
