//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Whitelist {

  address[] public users;
  address owner;

  mapping (address => bool) userWhitelisted;

  event whitelistUser(address _userAddress);

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  modifier isWhitelisted {
    require(userWhitelisted[msg.sender], "Your address are not in the whitelist");
    _;
  }

  function addToWhitelist(address _userAddress) external onlyOwner {
    require(!userWhitelisted[_userAddress], "Address already whitelisted");

    users.push(_userAddress);
    userWhitelisted[_userAddress] = true;

    emit whitelistUser(_userAddress);
  }

  function removeFromWhitelist(address _userAddress) external onlyOwner {
    require(userWhitelisted[_userAddress], "This address is not whitelisted");

    userWhitelisted[_userAddress] = false;

    return;
  }

  function checkWhitelist(address _userAddress) external view returns(bool){
    return userWhitelisted[_userAddress];
  }
}