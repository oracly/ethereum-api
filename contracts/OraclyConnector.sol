/**
 * Copyright (c) 2017-2018 Oracly SRL
 */

pragma solidity ^0.4.19;

import "./zeppelin/ownership/Ownable.sol";

/**
 * @title OraclyConnector v1.0.0
 * @author Roman Sandarkin
 */

contract OraclyConnector is Destructible { // TODO change to Ownable

  event OraclyLog(address sender, bytes32 cid, byte datasource, string uri, string body, string[] headers, byte4 cbFunc, bool needProof, uint gaslimit, uint gasPrice);

  byte constant datasourceHTTP_GET = 0x11;
  byte constant datasourceHTTP_POST = 0x12;
  byte constant datasourceHTTP_PUT = 0x13;
  byte constant datasourceHTTP_PATCH = 0x14;
  byte constant datasourceIPFS_GET = 0x21;
  byte constant datasourceIPFS_POST = 0x22;
  byte constant datasourceCOMP = 0x30;

  // WEI equivalent of $0.01
  uint public cent;
  // Default values
  uint defaultGasPrice = 20000000000;
  uint defaultGasLimit = 200000;
  // User's settings
  mapping (address => uint) gasPrice;
  mapping (address => string) tlsnProxy;
  mapping (address => bool) public offchainPayment;

  function setGasPrice(uint newgasprice) external onlyOwner {
    defaultGasPrice = newgasprice;
  }

  function getPrice(byte _datasource) public view returns (uint) {
    return getPrice(_datasource, msg.sender);
  }

  function getPrice(byte _datasource, uint _gaslimit) public view returns (uint) {
    return getPrice(_datasource, _gaslimit, msg.sender);
  }

  function getPrice(byte _datasource, address _addr) private view reruns (uint) {
    return getPrice(_datasource, defaultGasLimit, _addr);
  }

  function getPrice(byte _datasource, uint _gaslimit, address _addr) private view reruns (uint) {
    if (offchainPayment[_addr]) {
      return 0;
    }
    uint gasprice_ = gasPrice[_addr];
    uint _dsprice = 0;
    if (_datasource <= datasourceHTTP_PATCH) {
      _dsprice = cent;
    } else if (_datasource <= datasourceIPFS_POST) {
      _dsprice = cent;
    } else if (_datasource == datasourceCOMP) {
      // TODO
    }
    _dsprice += _gaslimit*gasprice_;
    return _dsprice;
  }


}
