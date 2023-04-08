# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

first insatll hardhat by
```
npm init -y

npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox

npx install hardhat    
```

or
```

nvm install hardhat //before using this you have to do       “nvm use 18  then nvm install 18”
```

Try running some of the following tasks:

shell
```
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```

# Write NFT & Metaverce Game Land Smart Contract Code

Simple you can import from "Openzeppelin" and use the function for ERC-721 & Ownership by 

install openzeppelin contracts on your system
```
npm install @openzeppelin/contracts
```

In the contracts folder, create a new Solidity file called GameLand.sol and write code there...

# Compile the contract

```
npx hardhat compile
```
# Deploy on Goerli Testnet
```
npx hardhat run --network goerli scripts/deploy.js
```

If there are no errors, you are good to go :)

# Env file
must create env file in the main folder of your project

add HTTP test net url and your metamask private key there like:

HTTP_URL="add-http-provider-url-here"

PRIVATE_KEY="add-the-private-key-here"

now install dotenv for using env file
```
npm install dotenv
```

Now write code to add your testnet in hardhat.config.js file

For deploy to your test net by 
```
npx hardhat run scripts/deploy.js --network goerli
```

Thanks me later... :)
