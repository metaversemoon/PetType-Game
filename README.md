### Github: https://github.com/metaversemoon/PetType-Game
- `WorldCoin` makes sure users create only one event for a class per person to avoid any scams.
### WorldCoin Link: https://github.com/metaversemoon/PetType-Game/blob/a803a6ac8637344e553ab20943aaed46aeb187c1/PetWorldCoin.sol#L10


# Pet Type Game with Pet a Feeding Concept

In this typing game with a pet feeding concept,
users create an account and set up a virtual pet by choosing a pet and naming it. They start with a default amount of calories for their pet. The typing game is the core activity, where users play to earn calories for their pet by correctly typing words. Different difficulty levels or game modes offer varying caloric rewards. Users can monitor their pet's status on a virtual dashboard and must feed their pet 120 calories every 24 hours to keep it alive. The pet has a lifecycle, and if it doesn't receive the required calories within the timeframe, it "dies." Users can earn rewards or achievements for keeping their pet alive for extended periods, adding a challenge and incentive to the game.

## Quickstart

To get started with this project, follow the steps below:

1. Clone this repo & install dependencies

```
git clone https://github.com/electrone901/PetType-Quest.git
cd PetType-Quest
yarn install
```

2. Copy the .env.example file and change name to .env.local. Set the MONGO_URI to the database you are using.

3. In the terminal, start your the project:

```
yarn start
```

Visit your app on: `http://localhost:3000`.

## Technologies

For this project, our technology stack encompasses several key components:

We utilize IPFS-NFTStorage to securely store all user information. This ensures data integrity and reliability.

Our smart contract development relies on Solidity and Hardhat, providing a robust and well-tested foundation for our blockchain operations.

For local blockchain development and testing, we turn to Hardhat, which facilitates efficient and reliable development workflows.

On the frontend, we harness the power of Tailwind, Next.js, and React.js to create an engaging and user-friendly interface. Ethers.js serves as the bridge to connect with the blockchain.


## How is made

- `WorldCoin` makes sure users create only one event for a class per person to avoid any scams. Link: https://github.com/metaversemoon/PetType-Game/blob/a803a6ac8637344e553ab20943aaed46aeb187c1/PetWorldCoin.sol#L10

- Mumbai Polygon Network Deployed app on the Polygon Mumbai Network(0x5FbDB2315678afecb367f032d93F642f64180aa3) for NFT donations, NFT creations, and stream payments for Street Vendors.

- Covalent Helps to display a dashboard of all transactions by contract and fetches all NFTS that were donated to on the food street vendor page.

* IPFS NFTStorage Used IPFS to store all food street vendor data facilitated the storage of NFTS, details of the class, and metadata of every event class. We are also, saving all the reviews, tags, class difficulty, class quality, and ratings.

* We used Solidity for the smart contract.

* We used OpenZeppelin ERC721 we use the ERC721 template for faster development of our smart contract.

* Hardhat for local blockchain development.

* We used Tailwindcss, React Js for the frontend, and Ethersjs to connect to the blockchain.


## Challenges we ran into
We run into some complications with the Smart contracts and the Chainlink integration, they took us longer than expected. Especially, creating a custome automation

## Accomplishments that we're proud of
We are proud of the final MVP and how our project went from an idea to a demo
### Github: https://github.com/metaversemoon/PetType-Game
