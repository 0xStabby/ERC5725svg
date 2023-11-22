// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {VestData} from "../libs/VestData.sol";

library MetadataBuilder {
  function buildMetadata(uint id, string memory description, string memory image, VestData.Vdata memory vestdata) internal pure returns (string memory) {
    string memory dataURI = string(abi.encodePacked(
      '{ "name": "', 'ERC5725svg #', Strings.toString(id), '",'
      , ' "description": "', description, '",'
      , ' "attributes": ['));

    dataURI = string(abi.encodePacked(dataURI
      , '{ "trait_type": "', "payout token: ", '",'
      , ' "value": "', vestdata.payoutToken, '" },'));

    dataURI = string(abi.encodePacked(dataURI
      , '{ "trait_type": "', "payout: ", '",'
      , ' "value": "', vestdata.payout, '" },'));

    dataURI = string(abi.encodePacked(dataURI
      , '{ "trait_type": "', "start time: ", '",'
      , ' "value": "', vestdata.startTime, '" },'));

    dataURI = string(abi.encodePacked(dataURI
      , '{ "trait_type": "', "end time: ", '",'
      , ' "value": "', vestdata.endTime, '" }'));

    dataURI = string(abi.encodePacked(dataURI, '], "image": "'));
    dataURI = string(abi.encodePacked(dataURI, image, '" }'));

    return dataURI;
  }
}

