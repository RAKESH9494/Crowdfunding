// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdFunding {

    //Crowdfunding Details
    address public Creator;
    uint public FundGoal;
    uint public TotalFund;
    bool public GoalReached;
    bool public ArtSold;
    uint public ArtPrice;

    // contributers -> amount
    mapping(address => uint) public contribution;

    // contributers -> Earnings
    mapping (address=>uint) public EarnedFromcontribution;

    //Address of contributers
    address[] public contributorAddresses;

    //Event logs
    event ContributionReceived(address contributor, uint amount);
    event GoalIsReached(uint TotalFund);
    event ArtSoldPrice(uint price);
    event FundsDistributed(uint SellPrice, uint profit);

    modifier onlyCreator() {
        require(msg.sender == Creator, "Only the creator can perform this action.");
        _;
    }

    constructor(uint _Goal) {
        Creator = msg.sender;
        FundGoal = _Goal;
        GoalReached = false;
        ArtSold = false;
    }

    // Contributing the amount
    function contribute(uint amount) public {
        require(!GoalReached, "Funding goal already reached.");
        require(amount > 0, "Contribution amount must be greater than zero.");

        if(contribution[msg.sender]!=0) revert("Already contributed");

        contribution[msg.sender] = amount;

        contributorAddresses.push(msg.sender);

        TotalFund = TotalFund + amount;

        emit ContributionReceived(msg.sender, amount);

        if (TotalFund >= FundGoal) {
            GoalReached = true;
            emit GoalIsReached(TotalFund);
        }
    }

    // To sell the Art
    function sellArt(uint _price) public onlyCreator {
        require(GoalReached, "Funding goal not reached.");
        require(!ArtSold, "Art is already sold.");

        ArtPrice = _price;
        ArtSold = true;

        emit ArtSoldPrice(_price);
        distributeFunds();
    }

    //Distributes the profit based on contributiong percentage
    function distributeFunds() internal {
        require(ArtSold, "Art is not sold.");
         
        uint profit;

        if(ArtPrice > FundGoal){
            profit = ArtPrice - FundGoal;
            for (uint i = 0; i < contributorAddresses.length; i++) {
                uint contributorProfit = (profit * contribution[contributorAddresses[i]]) / TotalFund;
                EarnedFromcontribution[contributorAddresses[i]] = contributorProfit;
            }
            emit FundsDistributed(ArtPrice,profit);
        } 

        else{
            for (uint i = 0; i < contributorAddresses.length; i++) {
                EarnedFromcontribution[contributorAddresses[i]] = 0;
            }
            emit FundsDistributed(ArtPrice,0);
        }
    }

    function getContributorAddresses() public view returns (address[] memory) {
        return contributorAddresses;
    }

    function getContribution(address contributorAddress) public view returns (uint) {
        return contribution[contributorAddress];
    }
}
