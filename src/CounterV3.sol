// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract CounterV3 is Initializable {
    /*     //this is bad
    // this is a new variable and should initially be zero but will it really be??
    //storage slot 0
    uint256[10] public myNumbersArray; */

    uint256 public number;

    uint256 public secondNumber;

    constructor( /* uint256 _initialNumber */ ) {
        //number = _initialNumber;
        _disableInitializers();
    }

    function initialize(uint256 _initialNumber, uint256 _secondNumber) public reinitializer(3) {
        number = _initialNumber;
        secondNumber = _secondNumber;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    function decrement() public {
        number--;
    }
}
