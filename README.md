# MoonToken-Faucet
A secure and efficient ERC20 Token Faucet built using Solidity.vThis contract allows users to claim a fixed number of tokens with cooldown restrictions to prevent abuse.

🚀 **Features**

- Token Distribution: Users can claim a predefined amount of tokens.

- Cooldown Mechanism: Enforces a cooldown period between claims.

- Token Management: Owner can deposit, withdraw, or adjust claim settings.

- Security: Includes onlyOwner modifier, require() checks, and event logging for transparency.

📂 **Contract Overview**

*TokenFaucet.sol*

- claimTokens() — Allows eligible users to claim tokens.

- depositTokens(uint256 amount) — Owner deposits tokens into the faucet.

- withdrawTokens(uint256 amount) — Owner withdraws tokens from the faucet.

- setClaimAmount(uint256 newAmount) — Owner sets the claim limit.

- setCooldownPeriod(uint256 newCooldown) — Owner sets the cooldown period.

- checkFaucetBalance() — Returns the faucet's available token balance.

- hasUserClaimed(address user) — Checks if a user has claimed tokens.

🛠️ **Deployment Instructions**

1. Deploy the ERC20 Token Contract (e.g., MyTokenFaucet.sol).

2. Deploy the TokenFaucet contract with:

- _tokenAddress — Address of the deployed ERC20 token.

- _claimAmount — Number of tokens each user can claim.

3. In the ERC20 contract:

- Use approve() to allow the Faucet contract to manage tokens.

- Example: approve(<Faucet_Address>, 100000000000000000000) for 100 tokens.

4. In the TokenFaucet contract:

- Use depositTokens() to fund the faucet.

⚙️ **Testing & Usage**

- Claim Tokens: Call claimTokens() to request tokens.

- Check Balance: Use checkFaucetBalance() to verify available tokens.

- Check Claim Status: Use hasUserClaimed() with a wallet address.

📜 **License**

This project is licensed under the MIT License.

🤝 **Contributing**

Contributions, suggestions, and improvements are welcome! Feel free to fork this repository and create a pull request.
-----------------------------------------------------------------------------
Developed for the Web3 Community.
