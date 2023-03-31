// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Telephone.sol";
import "../src/TelephoneAttacker.sol";

contract TelephoneAttackScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        address telephoneAddress = vm.envAddress("TELEPHONE_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        TelephoneAttacker attacker = new TelephoneAttacker(telephoneAddress);
        attacker.attack();
        vm.stopBroadcast();
    }
}
