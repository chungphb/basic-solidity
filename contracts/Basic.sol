// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Basic {
    // Test variable scope.
    uint public publicStateVar = 1073741824;
    uint internal internalStateVar = 1073741824;

    // Test variables.
    uint stateVar; // State variable.
    function testStateVariable() public {
        stateVar = 1073741824;
        emit printVariable(stateVar);
    }

    function testLocalVariable() public {
        uint localVar = 1073741824;
        emit printVariable(localVar);
    }

    function testGlobalVariable() public {
        uint globalVar = block.number;
        emit printVariable(globalVar);
    }

    event printVariable(uint _var);

    // Test types.
    function testTypes() public {
        bool boolVal = true;
        string memory stringVal = "Solidity";
        address addressVal = address(0);
        uint256 uint256Val = 1073741824;
        emit printTypes(boolVal, stringVal, addressVal, uint256Val);
    }

    function testAddressType() public {
        address sender = msg.sender;
        address receiver = address(0x101);
        emit printAddressType(sender, receiver);
    }

    event printTypes(bool _boolVal, string _stringVal, address _addressVal, uint256 _uint256Val);
    event printAddressType(address _sender, address _receiver);

    // Test comments.
    // This is a comment.
    /*
     * This is also a comment.
     */
}

contract DerivedBasic is Basic {
    function getInternalStateVariable() public view returns (uint) {
        return internalStateVar;
    }
}

contract BasicCaller {
    Basic basic = new Basic();
    function getPublicStateVariable() public view returns (uint) {
        return basic.publicStateVar();
    }
}
