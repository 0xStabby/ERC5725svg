// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

library MetadataBuilder {
  struct Attribute {
    string key; // these could be set on initialization
    string value; // these will come on call for token each id
    // hmm I get the values by function, maybe I can put a function fur the attribute value here
  }
  struct Metadata {
    string description;
    Attribute[] attributes;
  }

  function buildMetadata(uint id, string memory image, Metadata memory metadata) internal pure returns (string memory) {
    string memory dataURI = string(abi.encodePacked(
      '{ "name": "', 'ERC5725svg #', Strings.toString(id), '",'
      , ' "description": "', metadata.description, '",'
      , ' "attributes": ['));

    // could I pass a mapping of my attributes in
    // then I could loop through and add them
    // with attrubutes all being objects so I can easily access their label and value
    // oh wait, can't loop through mappings,
    // I could loop through an array of label/value objects tho

    for (uint i = 0; i < metadata.attributes.length; i++) {
      dataURI = string(abi.encodePacked(dataURI
        , '{ "trait_type": "', metadata.attributes[i].key, '",'
        , ' "value": "', metadata.attributes[i].value, '" },'));
    }

    /*
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
    */

    dataURI = string(abi.encodePacked(dataURI, '], "image": "'));
    dataURI = string(abi.encodePacked(dataURI, image, '" }'));

    return dataURI;
  }
}

