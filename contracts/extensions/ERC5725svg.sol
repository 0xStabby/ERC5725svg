// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {ERC5725} from "../ERC5725.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {AssetBuilder} from "@bitbytebin/onchain/contracts/libs/AssetBuilder.sol";
import {MetadataBuilder} from "@bitbytebin/onchain/contracts/libs/MetadataBuilder.sol";
import {Base64Encoder} from "@bitbytebin/onchain/contracts/libs/Base64Encoder.sol";
import {OnChainDataStructs} from "@bitbytebin/onchain/contracts/libs/OnChainDataStructs.sol";

abstract contract ERC5725svg is ERC5725 {
  function tokenURI(uint id) public view override returns (string memory) {
    return getMetadata(id);
  }

  function getTraits(uint id) public view returns (OnChainDataStructs.Trait[] memory) {
    OnChainDataStructs.Trait[] memory result = new OnChainDataStructs.Trait[](3);
    result[0] = OnChainDataStructs.Trait("payoutToken", string.concat("0x", toAsciiString(_payoutToken(id))));
    result[1] = OnChainDataStructs.Trait("startTime", Strings.toString(_startTime(id)));
    result[2] = OnChainDataStructs.Trait("endTime", Strings.toString(_endTime(id)));
    return result;
  }

  function getMetadata(uint id) public view virtual returns (string memory) {
    return Base64Encoder.encodeMetadata(
      MetadataBuilder.buildMetadata(
        id, getImage(id),
        OnChainDataStructs.Metadata(
          "name",
          "description",
          getTraits(id)
        )));
  }

  function getImage(uint id) public view virtual returns (string memory) {
    return Base64Encoder.encodeSvg(
      AssetBuilder.buildSvg(
        OnChainDataStructs.Metadata(
          "name",
          "description",
          getTraits(id)
        )));
  }

  function _toAsciiString(address x) internal pure returns (string memory) {
    bytes memory s = new bytes(40);
    for (uint i = 0; i < 20; i++) {
      bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
      bytes1 hi = bytes1(uint8(b) / 16);
      bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
      s[2*i] = char(hi);
      s[2*i+1] = char(lo);
    }
    return string(s);
  }

  function _char(bytes1 b) internal pure returns (bytes1 c) {
    if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
    else return bytes1(uint8(b) + 0x57);
  }
}
