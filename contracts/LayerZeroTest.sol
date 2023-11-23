// SPDX-License-Identifier: MIT
pragma solidity >=0.8.17;

import "https://github.com/LayerZero-Labs/solidity-examples/blob/main/contracts/lzApp/NonblockingLzApp.sol";

/*
    LayerZero Optimism Goerli
      lzChainId:10132 lzEndpoint:0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1
      contract: 0x22063bC54243d5cc0B66269C0d15449C95e8eA6c
    LayerZero Goerli
      lzChainId:10121 lzEndpoint:0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23
      contract: 0xb8C2e35437295315244c2c747b7D18f0749011fA
*/

contract LayerZeroTest is NonblockingLzApp {
    string public data = "Nothing received yet";
    uint16 destChainId;
    
    constructor(address _lzEndpoint) NonblockingLzApp(_lzEndpoint) Ownable(msg.sender) {
        if (_lzEndpoint == 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1) destChainId = 10121;
        if (_lzEndpoint == 0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23) destChainId = 10132;
    }

    function _nonblockingLzReceive(uint16, bytes memory, uint64, bytes memory _payload) internal override {
       data = abi.decode(_payload, (string));
    }

    function send(string memory _message) public payable {
        bytes memory payload = abi.encode(_message);
        _lzSend(destChainId, payload, payable(msg.sender), address(0x0), bytes(""), msg.value);
    }

    function trustAddress(address _otherContract) public onlyOwner {
        trustedRemoteLookup[destChainId] = abi.encodePacked(_otherContract, address(this));   
    }
}
