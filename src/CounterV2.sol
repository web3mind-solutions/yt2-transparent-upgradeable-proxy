// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract CounterV2 is Initializable {
    //storage slot 0
    uint256 public number;

    constructor( /* uint256 _initialNumber */ ) {
        //number = _initialNumber;
        _disableInitializers();
    }

    function initialize(uint256 _initialNumber) public initializer {
        number = _initialNumber;
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
