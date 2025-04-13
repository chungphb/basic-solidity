// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Basic {
    // This is a comment.
    /*
     * This is also a comment. 
     */
    function getSum(uint _x, uint _y) public pure returns (uint) {
        return _x + _y;
    }
}
