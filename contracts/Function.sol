// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Function {
    // Test fallback functions.
    function testFallback(Receiver receiver) public {
        (bool success,) = address(receiver).call(abi.encodeWithSignature("nonExistingFunction()"));
        require(success);
    }

    /* Pure functions.
     * - Ensure that they will not read or modify the state.
     * - E.g. Not:
     *      - Reading state variables.
     *      - Accessing address(this).balance or <address>.balance.
     *      - Accessing any of the special variable of block, tx, msg (msg.sig and msg.data can be read).
     *      - Calling any function not marked pure.
     *      - Using inline assembly that contains certain opcodes.
     */
    
    /* View functions.
     * - Ensure that they will not modify the state.
     * - E.g. Not:
     *      - Modifying state variables.
     *      - Emitting events.
     *      - Creating other contracts.
     *      - Using selfdestruct.
     *      - Sending Ether via calls.
     *      - Calling any function which is not marked view or pure.
     *      - Using low-level calls.
     *      - Using inline Assembly containing certain opcodes.
     */
    
    // Test function modifiers.
}

// Test fallback functions.
contract Receiver {
    event Received(address sender, uint amount);
    event FallbackCalled(address sender, uint amount, bytes data);
    
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        require(msg.value > 0, "Must send some Ether");
    }
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
