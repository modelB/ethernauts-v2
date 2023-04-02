// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CoinFlip.sol";
import "../src/Attacker.sol";
import "../src/Telephone.sol";
import "../src/TelephoneAttacker.sol";
import "../src/GatekeeperOne.sol";
import "../src/GatekeeperOneAttacker.sol";

contract AttackerTest is Test {
    CoinFlip public coinFlip;
    Attacker public attacker;
    address public deployer;
    Telephone public telephone;
    TelephoneAttacker public telephoneAttacker;

    event AttackExecuted(uint256 consecutiveWins);

    function setUp() public {
        deployer = vm.addr(1);
        coinFlip = new CoinFlip();
        attacker = new Attacker(address(coinFlip));
        telephone = new Telephone();
        telephoneAttacker = new TelephoneAttacker(
            address(telephone)
        );
    }

    function testAttack() public {
        vm.expectEmit(true, false, false, false);
        emit AttackExecuted(1);
        attacker.attack();
        assertEq(coinFlip.consecutiveWins(), 1);
    }

    function testTelephoneAttack() public {
        vm.startPrank(deployer);
        address oldOwner = telephone.owner();
        telephoneAttacker.attack();
        assertTrue(telephone.owner() != oldOwner);
        assertEq(telephone.owner(), deployer);
    }

    function testFuzz_GateKeeperOne(uint256 gas) public {
        gas = bound(gas, 5000, .5 ether);
        GatekeeperOne gatekeeper = new GatekeeperOne();
        GatekeeperOneAttacker gateKeeperAttacker = new GatekeeperOneAttacker();
        vm.startPrank(deployer);
        vm.expectRevert();
        gateKeeperAttacker.attack(address(gatekeeper), gas);
        vm.stopPrank();
    }

    function test_GateKeeperOne() public {
        GatekeeperOne gatekeeper = new GatekeeperOne();
        GatekeeperOneAttacker gateKeeperAttacker = new GatekeeperOneAttacker();
        vm.startPrank(deployer);
        vm.expectRevert();
        gateKeeperAttacker.attack(address(gatekeeper), 130378705645490337);
        vm.stopPrank();
    }
}
