// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Basic {
    // Test array.
    uint[3] public fixedArr = [1, 2, 3];

    function getElementOfFixedArray(uint _index) public view returns (uint) {
        require(_index < 3, "Index out of bounds");
        return fixedArr[_index];
    }
    
    uint[] public dynamicArr;

    function addElementOfDynamicArray(uint _value) public {
        dynamicArr.push(_value);
    }

    function removeLastElementOfDynamicArray() public {
        dynamicArr.pop();
    }

    function getLengthOfDynamicArray() public view returns (uint) {
        return dynamicArr.length;
    }

    function getElementOfDynamicArray(uint _index) public view returns (uint) {
        require(_index < dynamicArr.length, "Index out of bounds");
        return dynamicArr[_index];
    }

    // Test operators, loops and decision making.
    function testMultipleThings(uint _var) public pure returns (string memory) {
        return convertIntegerToString(_var);
    }

    function convertIntegerToString(uint _var) private pure returns (string memory) {
        if (_var == 0) {
            return "0";
        }
        uint i = _var;
        uint len = 0;
        while (i != 0) {
            len++;
            i /= 10;
        }
        bytes memory buf = new bytes(len);
        uint j = len - 1;
        do {
            buf[j] = bytes1(uint8(48 + _var % 10));
            if (j == 0) {
                break;
            }
            j--;
            _var /= 10;
        } while (j >= 0);
        return string(buf);
    }

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
