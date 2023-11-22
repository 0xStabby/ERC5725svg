// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {ERC5725} from "../ERC5725.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {AssetBuilder} from "../libs/AssetBuilder.sol";
import {MetadataBuilder} from "../libs/MetadataBuilder.sol";
import {Base64Encoder} from "../libs/Base64Encoder.sol";
import {VestData} from "../libs/VestData.sol";

abstract contract ERC5725svg is ERC5725 {
  function tokenURI(uint id) public view override returns (string memory) {
    return metadata(id);
  }

  function metadata(uint id) public view virtual returns (string memory) {
    VestData.Vdata memory vestdata;
    vestdata.payout = Strings.toString(_payout(id));
    vestdata.payoutToken = string.concat("0x", toAsciiString(_payoutToken(id)));
    vestdata.startTime = Strings.toString(_startTime(id));
    vestdata.endTime = Strings.toString(_endTime(id));

    string memory image = AssetBuilder.buildSvg(vestdata);
    image = Base64Encoder.encodeSvg(image);
    string memory dataURI = MetadataBuilder.buildMetadata(id, "some description", image, vestdata);
    dataURI = Base64Encoder.encodeMetadata(dataURI);

    return dataURI;
  }

  function toAsciiString(address x) internal pure returns (string memory) {
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

  function char(bytes1 b) internal pure returns (bytes1 c) {
    if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
    else return bytes1(uint8(b) + 0x57);
  }
}
