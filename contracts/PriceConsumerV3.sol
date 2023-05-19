// SPDX-License-Identifier: GPL-3.0
pragma solidity >0.5.0;

import "@chainlink/contracts/src/v0.5/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {
    
    AggregatorV3Interface public priceFeed;

    uint8 decimals;

    constructor() public {
        priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    }

    function getLatestPrice() public view returns (int) {
        (, int price, , ,) = priceFeed.latestRoundData();
        return price;
    }

    function getDecimals() public view returns (uint8) {
        uint8 decimals = priceFeed.decimals();
        return decimals;
    }
}