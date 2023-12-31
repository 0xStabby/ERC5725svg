# erc5725svg: ERC5725 extension for on chain svgs from data
[![lint & test](https://github.com/ERC-5725/ERC-5725-reference/actions/workflows/lint-test.yml/badge.svg)](https://github.com/ERC-5725/ERC-5725-reference/actions/workflows/lint-test.yml)
[![Docs](https://img.shields.io/badge/docs-%F0%9F%93%84-yellow)](./docs/)
[![License](https://img.shields.io/badge/License-GPLv3-green.svg)](https://www.gnu.org/licenses/gpl-3.0)

This repository serves as both a reference implementation and an sdk module for ERC-5725 Transferrable Vesting NFT Standard.

## EIP-5725

"A Non-Fungible Token (NFT) standard used to vest ERC-20 over a vesting release curve."  

Find the official [EIP located here](https://eips.ethereum.org/EIPS/eip-5725).

## Examples

The [ethers example](./examples/getVestingPeriod.ts) can be run quickly with `yarn example`.  

This [solidity reference](./contracts/reference/LinearVestingNFT.sol) shows how to extend `ERC5725.sol` to quickly create a transferrable vesting NFT.  

## `@erc-5725/sdk` Package Usage

### Installation

Add the ERC-5725 module to your Solidity, Frontend and/or Backend application.

```shell
npm install @erc-5725/sdk
# OR
yarn add @erc-5725/sdk
```

### Usage with Solidity Smart Contracts

Extend `ERC5725.sol` to quickly create a transferrable Vesting NFT contract implementation.

```js
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@erc-5725/sdk/contracts/ERC5725.sol";

contract LinearVestingNFT is ERC5725 { ... }
```

### Usage with Frontend/Backend Node Applications

Quickly interact with an ERC5725 contract by providing an `ethers` provider.

#### Quickly Read ERC-5725 Values

By simply passing an RPC provider URL, state from an ERC-5725 contract can be read quickly.

```ts
// Import ERC-5725 contract helper function
import { getERC5725Contract, IERC5725_Artifact } from '@erc-5725/sdk'
const IERC5725_ABI = IERC5725_Artifact.abi
import { ethers } from 'ethers'
// Very quickly send txs to/read from type safe ERC-5725 contract
const provider = await ethers.getDefaultProvider('https://bscrpc.com')
// Obtain a type safe ERC-7525 contract
const erc5725Contract = getERC5725Contract('<erc-5725-address>', provider)
// Read vestingPeriod 
const { vestingStart, vestingEnd } = await erc5725Contract.vestingPeriod('<token-id>') 
```

#### MetaMask Integration

By simply passing an RPC provider URL, state from an ERC-5725 contract can be read quickly.

```ts
// Import ERC-5725 contract helper function
import { getERC5725Contract, IERC5725_Artifact } from '@erc-5725/sdk'
const IERC5725_ABI = IERC5725_Artifact.abi
import { ethers } from 'ethers'
// Pull out the injected ethereum provider from MetaMask in browser
const { ethereum } = window
const provider = new ethers.providers.Web3Provider(ethereum)
const signer = provider.getSigner()
// Setup ERC-5725 instance with a signer
const erc5725Contract = getERC5725Contract('<erc-5725-address>', signer)
// Claim payoutTokens
const tx = await erc5725Contract.claim('<token-id>')
await tx.wait()
```

## Usage via Clone

- `git clone git@github.com:ERC-5725/ERC-5725-reference.git`
- `cd ERC-5725-reference`
- `yarn`
- Copy [.env.example](./.env.example) and rename to `.env`
  - Provide the necessary `env` variables before deployment/verification
  - `MAINNET_MNEMONIC`/`TESTNET_MNEMONIC` for deployments
  - `<explorer>_API_KEY` for verifications
- [hardhat.config.ts](./hardhat.config.ts): Can be configured with additional networks if needed

### Deployment and Verification

This project uses special tasks, adapted from Balancer protocol, to deploy and verify contracts which provides methods for saving custom outputs and easily verifying contracts as well as compartmentalizing different types of deployments.

#### Default (yarn script) Deployment and Verification

Deploy [20230212-vesting-nft](./tasks/20230212-vesting-nft/) task to the network of your choice  
`yarn deploy <network-name>`  

<br>

Verify [20230212-vesting-nft](./tasks/20230212-vesting-nft/) on the network of your choice  
`yarn verify <network-name> --name <LinearVestingNFT|VestingNFT>`  

#### Hardhat Deployment and Verification

Deploy using hardhat tasks  
`npx hardhat deploy --id 20230212-vesting-nft --network <network-name>`  

<br>

Verify using hardhat tasks  
`npx hardhat verify-contract --id 20230212-vesting-nft --network <network-name> --name <LinearVestingNFT|VestingNFT>`   


### Linting

This project uses Prettier, an opinionated code formatter, to keep code styles consistent. This project has additional plugins for Solidity support as well. 

#### Linting Solidity Code

- [prettier.config.js](./prettier.config.js): Provide config settings for Solidity under `overrides`.
- [.solhint.json](./.solhint.json): Provide config settings for `solhint`.  

- `yarn lint`: Lint Solidity & TS/JS files
- `yarn lint:fix`: Fix Solidity & TS/JS files
