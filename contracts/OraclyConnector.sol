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

  byte constant datasourceHTTP = 0x10;
  byte constant datasourceCOMP = 0x20;
  byte constant datasourceIPFS = 0x30;

  // WEI equivalent of $0.01
  uint public cent;
  uint defaultGasPrice = 20000000000;
  uint defaultGasLimit = 200000;
  mapping (address => uint) gasPrice;
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
    if (_datasource == datasourceHTTP) {
      _dsprice = cent;
    }
    if (_datasource == datasourceCOMP) {
      // TODO
    }
    _dsprice += _gaslimit*gasprice_;
    return _dsprice;
  }


}
