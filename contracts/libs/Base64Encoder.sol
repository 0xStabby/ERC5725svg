// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Constants} from "./Constants.sol";
import {Base64} from "base64-sol/base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

library Base64Encoder {
  function encodeMetadata(string memory metadata) internal pure returns (string memory) {
    metadata = Base64.encode(bytes(metadata));
    metadata = string(abi.encodePacked(
      Constants.JSON_URI_PREFIX,
      metadata
    ));
    return metadata;
  }

  function encodeSvg(string memory image) internal pure returns (string memory) {
    image = Base64.encode(bytes(image));
    image = string(abi.encodePacked(
      Constants.SVG_URI_PREFIX,
      image
    ));
    return image;
  }
}
