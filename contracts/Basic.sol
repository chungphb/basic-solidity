// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Basic {
    // Test special variables and functions.
    function testSpecialVariablesAndFunctions() internal view {
        uint curBlockNumber = block.number;
        bytes32 curBlockHash = blockhash(curBlockNumber);
        uint curBlockBaseFee = block.basefee;
        uint curBlockChainId = block.chainid;
        address curBlockMinerAddress = block.coinbase;
        uint curBlockDifficulty = block.difficulty;
        uint curBlockGasLimit = block.gaslimit;
        uint curBlockTimestampt = block.timestamp;
        
        uint256 gasLeft = gasleft();

        bytes calldata msgData = msg.data;
        address msgSender = msg.sender;
        bytes4 msgSig = msg.sig;
        uint msgValue = msg.value;
        
        uint txGasPrice = tx.gasprice;
        address txOrigin = tx.origin;
    }

    // Test time units.
    function testTimeUnits() public pure {
        assert(1 seconds == 1);
        assert(1 minutes == 60 seconds);
        assert(1 hours == 60 minutes);
        assert(1 days == 24 hours);
        assert(1 weeks == 7 days);
    }

    // Test ether units.
    function testEtherUnits() public pure {
        assert(1 wei == 1);
        assert(1 gwei == 1e9);
        assert(1 ether == 1e18);
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
        emit PrintVariable(stateVar);
    }

    function testLocalVariable() public {
        uint localVar = 1073741824;
        emit PrintVariable(localVar);
    }

    function testGlobalVariable() public {
        uint globalVar = block.number;
        emit PrintVariable(globalVar);
    }

    event PrintVariable(uint _var);

    // Test types.
    function testTypes() public {
        bool boolVal = true;
        string memory stringVal = "Solidity";
        address addressVal = address(0);
        uint256 uint256Val = 1073741824;
        emit PrintTypes(boolVal, stringVal, addressVal, uint256Val);
    }

    function testAddressType() public {
        address sender = msg.sender;
        address receiver = address(0x101);
        emit PrintAddressType(sender, receiver);
    }

    event PrintTypes(bool _boolVal, string _stringVal, address _addressVal, uint256 _uint256Val);
    event PrintAddressType(address _sender, address _receiver);

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

contract TestArray {
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
}

contract TestEnum {
    enum Pet { CAT, DOG, SNAKE }
    Pet pet;
    Pet constant defaultPet = Pet.DOG;

    function adoptPet(Pet _pet) public {
        pet = _pet;
    }

    function getPet() public view returns (Pet) {
        return pet;
    }

    function getDefaultPet() public pure returns (Pet) {
        return defaultPet;
    }
}

contract TestStruct {
    struct Person {
        string name;
        uint age;
    }
    Person[] people;

    function addPerson(string memory _name, uint _age) public {
        Person memory person = Person(_name, _age);
        people.push(person);
    }

    function removePerson(uint index) public {
        require(index < people.length, "Index out of bounds");
        for (uint i = index; i < people.length; ++i) {
            people[i] = people[i + 1];
        }
        people.pop();
    }

    function getPerson(uint index) public view returns (Person memory) {
        require(index < people.length, "Index out of bounds");
        return people[index];
    }
    
    function getNumberOfPeople() public view returns (uint) {
        return people.length;
    }
}

contract TestMapping {
    mapping(address => uint256) public balance;
        
    function setBalanceOfAddressToValue(address _addr, uint8 _value) public {
        require(_addr != address(0), "Invalid address");
        require(_value >= 1 && _value <= 9, "Invalid value");
        balance[_addr] = uint256(_value);
    }
}
