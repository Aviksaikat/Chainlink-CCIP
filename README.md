# Chainlink CCIP Testing


## Setup

- Make sure you have `foundry` installed. Follow the steps mentioned below to tnstall the deps. 

```sh
chmod +x setup.sh
./setup.sh
```

- Setup the env file with your RPC url & private keys.

## Test

```sh
forge test --match-test test_tranferTokensFromEoaToEoaPayFeesInLink -vvvv --fork-url $AVALANCHE_FUJI_RPC_URL
```