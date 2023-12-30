# Solidity API

## ERC5725svg

### tokenURI

```solidity
function tokenURI(uint256 id) public view returns (string)
```

### getTraits

```solidity
function getTraits(uint256 id) public view returns (struct OnChainDataStructs.Trait[])
```

### getMetadata

```solidity
function getMetadata(uint256 id) public view virtual returns (string)
```

### getImage

```solidity
function getImage(uint256 id) public view virtual returns (string)
```

### toAsciiString

```solidity
function toAsciiString(address x) internal pure returns (string)
```

### char

```solidity
function char(bytes1 b) internal pure returns (bytes1 c)
```

