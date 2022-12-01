// SPDX-License-Identifier: MIT
pragma solidity >=0.8.17;

import "https://github.com/LayerZero-Labs/solidity-examples/blob/main/contracts/lzApp/NonblockingLzApp.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/*
    LayerZero Optimism Goerli
      lzChainId:10132 lzEndpoint:0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1
      contract: 0x8B320E83c7CA097E98DA2eA2035bE78dA94389Ce
    LayerZero Goerli
      lzChainId:10121 lzEndpoint:0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23
      contract: 0xDD3f986D006Cb4061c3D3E94d8BdcfFE4F295125
*/

contract CrossChainToken is NonblockingLzApp, ERC20 {
    uint16 destChainId;
    
    constructor(address _lzEndpoint) NonblockingLzApp(_lzEndpoint) ERC20("Cross Chain Token", "CCT") {
        if (_lzEndpoint == 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1) destChainId = 10121;
        if (_lzEndpoint == 0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23) destChainId = 10132;
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function _nonblockingLzReceive(uint16, bytes memory, uint64, bytes memory _payload) internal override {
       (address toAddress, uint amount) = abi.decode(_payload, (address,uint));
       _mint(toAddress, amount);
    }

    function bridge(uint _amount) public payable {
        _burn(msg.sender, _amount);
        bytes memory payload = abi.encode(msg.sender, _amount);
        _lzSend(destChainId, payload, payable(msg.sender), address(0x0), bytes(""), msg.value);
    }

    function trustAddress(address _otherContract) public onlyOwner {
        trustedRemoteLookup[destChainId] = abi.encodePacked(_otherContract, address(this));   
    }
}