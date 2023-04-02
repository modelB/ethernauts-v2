// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    // console.log("gasleft 1: %s", gasleft());
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    // emit GasLeft(gasleft());
    // require(gasleft() % 8191 > 0);

    // console.log('before gate 2');
    // require(true);
    // console.log(gasleft());
    // console.logUint(gasleft());
    require(gasleft() % 8191 == 0, 'gas fail');
    // console.log('past gate 2');
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo returns (bool) {
    entrant = tx.origin;
    return true;
  }

  // event GasLeft(uint256 gasleft);
}