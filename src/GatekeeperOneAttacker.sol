// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./GatekeeperOne.sol";

contract GatekeeperOneAttacker {
    function attack(address target, uint256 gas) public {
        GatekeeperOne(target).enter{gas: gas}(bytes8(uint64(2**64 - 1)));
    }
}
