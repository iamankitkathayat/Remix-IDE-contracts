// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.8.0;

contract SimpleAuction {

    address payable public beneficiary;
    uint public auctionEndTime;

    // Current state of the auction
    address public highestBidder;
    uint public hightestBid;

    // Allowed withdrawals of previous bids
    mapping(address => uint) pendingReturns;

    // By default initialized to `false`.
    bool ended;

    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    /// The auction has already ended.
    error AuctionAlreadyEnded();
    /// There is already a higher or equal bid.
    error BidNotHighEnough(uint HighestBid);
    /// The auction has not ended yet.
    error AuctionNotYetEnded();
    /// The function auctionEnd has already been called.
    error AuctionEndAlreadyCalled();

    constructor(
        uint biddingTime;
        address payable beneficiaryAddress;
    ) public {
        beneficiary = beneficiaryAddress;
        auctionEndTime = block.timestamp + biddingTime;
    }

}
