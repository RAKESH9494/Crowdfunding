## Description

The  smart contract is a simple crowdfunding platform where contributors can fund a project with a set goal. Once the funding goal is reached, the creator can sell an art piece and distribute the profit (if any) to the contributors based on their contributions.


### Contract Overview

- **Creator**: The address of the person who deployed the contract, who is also the only one authorized to sell the art.
- **FundGoal**: The target amount of funds to be raised.
- **TotalFund**: The total amount of funds raised so far.
- **GoalReached**: A boolean indicating if the funding goal has been met.
- **ArtSold**: A boolean indicating if the art piece has been sold.
- **ArtPrice**: The price at which the art was sold.

### Mappings

- **contribution**: stores the amount contributed by each address.
- **EarnedFromcontribution**: stores the profit earned by each contributor based on their contribution.
- **contributorAddresses**: storing the addresses of all contributors.

### Events

- **ContributionReceived**: Emitted when a contribution is received.
- **GoalIsReached**: Emitted when the funding goal is reached.
- **ArtSoldPrice**: Emitted when the art is sold.
- **FundsDistributed**: Emitted when the funds are distributed.


### Functions

#### `contribute(uint amount)`

- Allows users to contribute funds to the project.

#### `sellArt(uint _price)`

- Allows the creator to sell the art at a specified price.

#### `distributeFunds()`

- Distributes the profit from selling the art to the contributors based on their contribution percentage.

#### `getContributorAddresses()`

- Returns the list of contributor addresses.

#### `getContribution(address contributorAddress)`

- Returns the contribution amount of a specific contributor.
