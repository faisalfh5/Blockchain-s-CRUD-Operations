//SPDX-License-Identifier: MIT
pragma solidity >0.5.0 <=0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GameLand is ERC721, Ownable {
    
    //Struct to define the properties of a land
    struct Land {
        uint256 id;
        string name;
        string description;
        address owner;
        uint256 price;
        bool isForSale;
        bool isForRent;
        uint256 rentDuration; //in days
        uint256 rentPrice;
        bool isAvailable;
    }
    
    //Maps a token ID to a land
    mapping(uint256 => Land) public lands;
    
    //Maps an owner address to an array of their token IDs
    mapping(address => uint256[]) public ownerLands;
    
    //Maps an address to another address to the duration of a rent
    mapping(address => mapping(address => uint256)) public allowance;
    
    uint256 public totalLands = 0; //The total number of lands created
    
    //Minimum rent duration in seconds
    uint256 public constant RENT_DURATION_MIN = 1 days;
    
    constructor() ERC721("GameLand", "GLAND") {}
    
    //Function to create a new land token
    function createLand(string memory _name, string memory _description, uint256 _price) public returns (uint256) {
        totalLands++; //Increments the total number of lands
        uint256 tokenId = totalLands; //Assigns the new token ID
        _mint(msg.sender, tokenId); //Mints a new token and assigns the ownership to the caller
        lands[tokenId] = Land(tokenId, _name, _description, msg.sender, _price, true, false, 0, 0, true); //Assigns the land properties to the land mapping
        ownerLands[msg.sender].push(tokenId); //Adds the new token ID to the array of token IDs owned by the caller
        return tokenId; //Returns the new token ID
    }
    
    //Function to update the properties of an existing land token
    function updateLand(uint256 _tokenId, string memory _name, string memory _description, uint256 _price, bool _isForSale, bool _isForRent, uint256 _rentDuration, uint256 _rentPrice, bool _isAvailable) public {
        Land storage land = lands[_tokenId]; //Assigns the land to a storage variable
        require(msg.sender == land.owner, "Only land owner can update"); //Reverts if the caller is not the owner of the land
        land.name = _name; //Updates the name of the land
        land.description = _description; //Updates the description of the land
        land.price = _price; //Updates the price of the land
        land.isForSale = _isForSale; //Updates whether the land is for sale
        land.isForRent = _isForRent; //Updates whether the land is for rent
        land.rentDuration = _rentDuration; //Updates the duration of the rent
        land.rentPrice = _rentPrice; //Updates the price of the rent
        land.isAvailable = _isAvailable; //Updates whether the land is available for sale or rent
    }
    
    function rentLand(uint256 _tokenId, uint256 _duration) public payable {
    Land storage land = lands[_tokenId];
    require(land.isForRent, "Land is not for rent"); // check if land is for rent
    require(msg.value >= land.rentPrice * _duration, "Insufficient payment"); // check if payment is enough to rent for given duration
    require(land.isAvailable, "Land is not available for rent"); // check if land is available to be rented
    land.isForSale = false; // mark land as not for sale
    land.isForRent = false; // mark land as not for rent
    land.isAvailable = false; // mark land as not available
    land.owner.transfer(msg.value); // transfer payment to the land owner
    allowance[land.owner][msg.sender] = _duration; // set allowance of the renter for the land owner for the given duration
    }

function returnLand(uint256 _tokenId) public {
    Land storage land = lands[_tokenId];
    require(land.owner == msg.sender, "Only owner can return land"); // check if the caller is the owner of the land
    land.isForSale = true; // mark land as for sale
    land.isForRent = true; // mark land as for rent
    land.isAvailable = true; // mark land as available
    allowance[land.owner][msg.sender] = 0; // reset allowance for the owner and caller
    _transfer(land.owner, address(this), _tokenId); // transfer ownership of the land to the contract itself
    }

}
