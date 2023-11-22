import { ethers } from 'hardhat'
import { Signer } from 'ethers'
import { expect } from 'chai'
import { time } from '@nomicfoundation/hardhat-network-helpers'
// typechain
import {
  ERC20Mock__factory,
  ERC20Mock,
  ERC5725svgNFT__factory,
  ERC5725svgNFT,
} from '../typechain-types'

const testValues = {
  payout: '1000000000',
  lockTime: 60,
  buffer: 10,
  totalLock: 70,
}

describe('ERC5725svg NFT', function () {
  let accounts: Signer[]
  let erc5725svg: ERC5725svgNFT
  let mockToken: ERC20Mock
  let receiverAccount: string
  let unlockTime: number

  beforeEach(async function () {
    const ERC5725svg = (await ethers.getContractFactory(
      'ERC5725svgNFT'
    )) as ERC5725svgNFT__factory
    erc5725svg = await ERC5725svg.deploy('ERC5725svgNFT', 'SVG')
    await erc5725svg.deployed()

    const ERC20Mock = (await ethers.getContractFactory(
      'ERC20Mock'
    )) as ERC20Mock__factory
    mockToken = await ERC20Mock.deploy(
      '1000000000000000000000',
      18,
      'LockedToken',
      'LOCK'
    )
    await mockToken.deployed()
    await mockToken.approve(erc5725svg.address, '1000000000000000000000')

    accounts = await ethers.getSigners()
    receiverAccount = await accounts[1].getAddress()
    unlockTime = await createVestingNft(
      erc5725svg,
      receiverAccount,
      mockToken
    )
  })

  it('Returns data values from contract in token uri metadata and image', async function () {
    // TODO: More extensive testing of linear vesting functionality
    const totalPayout = await erc5725svg.vestedPayoutAtTime(0, unlockTime)
    expect(await erc5725svg.vestedPayout(0)).to.equal(0)
    await time.increase(testValues.totalLock)
    expect(await erc5725svg.vestedPayout(0)).to.equal(totalPayout)
    const tokenURI = await erc5725svg.tokenURI(0);
    console.log(tokenURI);
  })

})

async function createVestingNft(
  linearVestingNFT: ERC5725svgNFT,
  receiverAccount: string,
  mockToken: ERC20Mock
) {
  const latestBlock = await ethers.provider.getBlock('latest')
  const unlockTime =
    latestBlock.timestamp + testValues.lockTime + testValues.buffer
  const txReceipt = await linearVestingNFT.create(
    receiverAccount,
    testValues.payout,
    latestBlock.timestamp + testValues.buffer,
    testValues.lockTime,
    0,
    mockToken.address
  )
  await txReceipt.wait()
  return unlockTime
}
