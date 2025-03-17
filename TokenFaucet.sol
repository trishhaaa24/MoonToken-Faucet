// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";


contract TokenFaucet {
    IERC20 public token;
    address public owner;
    uint256 public claimAmount;
    uint256 public claimCooldown = 1 days;

    mapping(address => uint256) public lastClaimTime;
    mapping(address => bool) public hasClaimed;

    event TokensClaimed(address indexed user, uint256 amount);
    event TokensDeposited(address indexed owner, uint256 amount);
    event TokensWithdrawn(address indexed owner, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor(address _tokenAddress, uint256 _claimAmount) {
        token = IERC20(_tokenAddress);
        owner = msg.sender;
        claimAmount = _claimAmount;
    }

    function claimTokens() external {
        require(!hasClaimed[msg.sender], "You have already claimed your tokens");
        require(block.timestamp >= lastClaimTime[msg.sender] + claimCooldown, "Claim cooldown period active");
        require(token.balanceOf(address(this)) >= claimAmount, "Insufficient faucet balance");

        hasClaimed[msg.sender] = true;
        lastClaimTime[msg.sender] = block.timestamp;
        token.transfer(msg.sender, claimAmount);

        emit TokensClaimed(msg.sender, claimAmount);
    }

    function depositTokens(uint256 amount) external onlyOwner {
        require(token.transferFrom(msg.sender, address(this), amount), "Token transfer failed");
        emit TokensDeposited(msg.sender, amount);
    }

    function withdrawTokens(uint256 amount) external onlyOwner {
        require(token.transfer(msg.sender, amount), "Token withdrawal failed");
        emit TokensWithdrawn(msg.sender, amount);
    }

    function setClaimAmount(uint256 newAmount) external onlyOwner {
        require(newAmount > 0, "Claim amount must be greater than zero");
        claimAmount = newAmount;
    }

    function setCooldownPeriod(uint256 newCooldown) external onlyOwner {
        require(newCooldown >= 1 hours, "Cooldown must be at least 1 hour");
        claimCooldown = newCooldown;
    }

    function emergencyWithdrawAllTokens() external onlyOwner {
        uint256 contractBalance = token.balanceOf(address(this));
        require(contractBalance > 0, "No tokens to withdraw");
        token.transfer(msg.sender, contractBalance);
        emit TokensWithdrawn(msg.sender, contractBalance);
    }

    function checkFaucetBalance() external view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function hasUserClaimed(address user) external view returns (bool) {
        return hasClaimed[user];
    }
}
