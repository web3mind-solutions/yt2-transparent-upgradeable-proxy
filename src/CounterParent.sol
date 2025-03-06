// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CounterParent {
    //slot 0
    uint256 public parentNumber;
    //slot 1
    uint256 public anotherNumber;
    //slot 2
    uint256 public myThirdNumber;

    function setParentNumber(uint256 newNumber) public {
        parentNumber = newNumber;
    }

    function incrementParent() public {
        parentNumber++;
    }

    uint256[50] storageGap;
}
