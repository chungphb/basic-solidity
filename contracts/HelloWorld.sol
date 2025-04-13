// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HelloWorld {
    string value;

    constructor() {
        value = "Hello, world!";
    }

    function getValue() public view returns (string memory) {
        return value;
    }

    function setValue(string memory _value) public {
        value = _value;
    }
}
