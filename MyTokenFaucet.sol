// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract MyTokenFaucet is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MOON") {
        _mint(msg.sender, initialSupply * (10 ** decimals()));
    }
}
