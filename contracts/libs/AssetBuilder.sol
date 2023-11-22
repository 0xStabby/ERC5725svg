// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Constants} from "./Constants.sol";
import {Base64} from "base64-sol/base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {MetadataBuilder} from "./MetadataBuilder.sol";
import {VestData} from "./VestData.sol";


library AssetBuilder {
  function buildSvg(VestData.Vdata memory payout) internal pure returns (string memory) {
    uint cellSize = 30;
    string memory baseSvg = Constants.BASESVG;

    uint x = cellSize + cellSize / 2;
    uint y = cellSize + cellSize / 2;

    // payout token
    string memory newElement = string(
      abi.encodePacked(
        '<text x="', Strings.toString(x), '" y="', Strings.toString(y * 2), '" fill="white">',
        "payoutToken: ", payout.payoutToken,
        '</text>'
    ));
    baseSvg = string(abi.encodePacked(baseSvg, newElement));

    // payout
    newElement = string(
      abi.encodePacked(
        '<text x="', Strings.toString(x), '" y="', Strings.toString(y * 2), '" fill="white">',
        "payout: ", payout.payout,
        '</text>'
    ));
    baseSvg = string(abi.encodePacked(baseSvg, newElement));

    // start time
    newElement = string(
      abi.encodePacked(
        '<text x="', Strings.toString(x), '" y="', Strings.toString(y * 3), '" fill="white">',
        "startTime: ", payout.startTime,
        '</text>'
    ));
    baseSvg = string(abi.encodePacked(baseSvg, newElement));

    // end time
    newElement = string(
      abi.encodePacked(
        '<text x="', Strings.toString(x), '" y="', Strings.toString(y * 4), '" fill="white">',
        "endTime: ", payout.endTime,
        '</text>'
    ));
    baseSvg = string(abi.encodePacked(baseSvg, newElement));

    baseSvg = string(abi.encodePacked(baseSvg, Constants.SVGEND));

    return baseSvg;
  }
}
