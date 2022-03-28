pragma solidity ^0.4.12;
pragma experimental ABIEncoderV2;

// SPDX-License-Identifier: GPL-3.0

import "./Ownable.sol";
import "./SafeMath.sol";

contract Chaine_logistique is Ownable {

using SafeMath for uint256;

    // Model a Product
    struct Product {
        uint256 id;
        string idProd;
        string lot;
        string name;
        string lastProd;
        string dateAchat;
    }

    // Model a Lot
    struct Lot{ 
        uint256 id;
        uint256 NbProduct;
    }

    // Store Products
    // Fetch Product
    mapping(uint => Product) public products;
    mapping(uint => Lot) public lots;

    // Store Number of Products by Lot
    uint public ProductCount;

    // Store Number of Lot Count
    uint public LotCount;


    function addProduct (string memory _idProd, string memory _lot, string memory _name, string memory _lastProd, string memory _dateAchat) public {
        ProductCount ++;
        lots[st2num(_lot)].NbProduct++;
        products[ProductCount] = Product(ProductCount, _idProd, _lot, _name, _lastProd, _dateAchat);
    }

    function addLot() public {
        LotCount ++;
        lots[LotCount] = Lot(LotCount, 0);
    }


    function st2num(string memory numString) private pure returns(uint) {
        uint  val=0;
        bytes   memory stringBytes = bytes(numString);
        for (uint  i =  0; i<stringBytes.length; i++) {
            uint exp = stringBytes.length - i;
            bytes1 ival = stringBytes[i];
            uint8 uval = uint8(ival);
           uint jval = uval - uint(0x30);
   
           val +=  (uint(jval) * (10**(exp-1))); 
        }
      return val;
    }

    function compareStrings(string memory a, string memory b) public view returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

}
