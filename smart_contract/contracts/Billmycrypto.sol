// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BillMyCrypto is Ownable {
    IERC20 public usdc;
    address public platformWallet;
    uint256 public platformFeePercent = 2; // 2% platform fee

    struct Transaction {
        address user;
        uint256 amountUSDC;
        uint256 feeUSDC;
        bool isPaid;
    }

    mapping(uint256 => Transaction) public transactions;
    uint256 public transactionCount;

    event BillPaid(address indexed user, uint256 amountUSDC, uint256 feeUSDC, uint256 totalUSDC, uint256 transactionId);
    event BillConfirmed(uint256 indexed transactionId, address indexed user, uint256 amountUSDC, string status);

    // ✅ Fix: Pass `msg.sender` to the `Ownable` constructor
    constructor() Ownable(msg.sender) {
        usdc = IERC20(0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174); // Polygon USDC
        platformWallet = 0xDdB788a73EA47B5dAA8763E843F237D6D56ed1E3; // Platform wallet
    }

    function payBill(uint256 amount) external {
        uint256 fee = (amount * platformFeePercent) / 100;
        uint256 totalAmount = amount + fee;

        require(usdc.transferFrom(msg.sender, platformWallet, totalAmount), "USDC Transfer Failed");

        transactions[transactionCount] = Transaction(msg.sender, amount, fee, false);
        emit BillPaid(msg.sender, amount, fee, totalAmount, transactionCount);

        transactionCount++;
    }

    function confirmBillPayment(uint256 transactionId) external onlyOwner {
        require(!transactions[transactionId].isPaid, "Already confirmed");

        transactions[transactionId].isPaid = true;
        emit BillConfirmed(transactionId, transactions[transactionId].user, transactions[transactionId].amountUSDC, "Paid");
    }

    function updatePlatformWallet(address newWallet) external onlyOwner {
        platformWallet = newWallet;
    }

    function updatePlatformFee(uint256 newFee) external onlyOwner {
        require(newFee <= 5, "Fee too high");
        platformFeePercent = newFee;
    }
}
