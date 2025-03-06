// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CounterV1} from "../src/CounterV1.sol";
import {CounterV2} from "../src/CounterV2.sol";
import {CounterV3} from "../src/CounterV3.sol";

import {
    TransparentUpgradeableProxy,
    ProxyAdmin,
    ITransparentUpgradeableProxy
} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract CounterTest is Test {
    CounterV1 public counterV1;

    TransparentUpgradeableProxy contractProxy;

    address owner = makeAddr("owner");

    function setUp() public {
        // 1. deploy the implementation contract
        // 2. deploy the proxy
        counterV1 = new CounterV1();

        contractProxy = new TransparentUpgradeableProxy(address(counterV1), owner, "");
    }

    function test_Increment() public {
        //run the setup
        CounterV1(address(contractProxy)).increment();
        assertEq(CounterV1(address(contractProxy)).number(), 1);
    }

    function upgradetoV2() internal {
        vm.startPrank(owner);
        //upgrading steps
        // 1. deploy the new implementation
        // 2. Call the ProxyAdmin upgrade function
        // 2a. ProxyAdmin will forward the call to the proxy and upgrade
        //This is the keccak-256 hash of "eip1967.proxy.admin" subtracted by 1.
        bytes32 adminSlot = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;
        bytes32 data = vm.load(address(contractProxy), adminSlot);

        CounterV2 counterV2 = new CounterV2();
        uint256 initialNumber = 222;
        bytes memory initData = abi.encodeWithSelector(CounterV2.initialize.selector, initialNumber);

        address proxyAdmin = address(uint160(uint256(data)));
        ProxyAdmin(proxyAdmin).upgradeAndCall(
            ITransparentUpgradeableProxy(address(contractProxy)), address(counterV2), initData
        );
        vm.stopPrank();
    }

    function test_upgradeToV2() public {
        upgradetoV2();
        assertEq(CounterV2(address(contractProxy)).number(), 222);
        CounterV2(address(contractProxy)).decrement();
        assertEq(CounterV2(address(contractProxy)).number(), 221);
    }

    function upgradeToV3() internal {
        vm.startPrank(owner);
        //upgrading steps
        // 1. deploy the new implementation
        // 2. Call the ProxyAdmin upgrade function
        // 2a. ProxyAdmin will forward the call to the proxy and upgrade
        //This is the keccak-256 hash of "eip1967.proxy.admin" subtracted by 1.
        bytes32 adminSlot = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;
        bytes32 data = vm.load(address(contractProxy), adminSlot);

        CounterV3 counterV3 = new CounterV3();
        uint256 initialNumber = 222;
        uint256 intialSecondNumber = 333;
        bytes memory initData = abi.encodeWithSelector(CounterV3.initialize.selector, initialNumber, intialSecondNumber);

        address proxyAdmin = address(uint160(uint256(data)));
        ProxyAdmin(proxyAdmin).upgradeAndCall(
            ITransparentUpgradeableProxy(address(contractProxy)), address(counterV3), initData
        );
        vm.stopPrank();
    }

    function test_upgradeToV3() public {
        upgradetoV2();
        upgradeToV3();
        //console.log(CounterV3(address(contractProxy)).myNumbersArray(0));
    }
}
