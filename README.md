# LayerZero Example
 
A simple example of cross chain communications where I tested passing a string between Goerli and Optimism Goerli using LayerZero

I ran this on Remix you'll need to add Optimism Goerli testnet to Metamask using Chainlist.

Note that the chainId's that LayerZero uses are different from the real chain ID's

## Instructions

Copy the code into remix

Deploy on both networks using these lzEndpoints in the constructor argument.

### LayerZero Optimism Goerli
- lzChainId:10132
- lzEndpoint:0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1

### LayerZero Goerli
- lzChainId:10121
- lzEndpoint:0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23

Then use the trustAddress(address _otherContract) function to approve the other contract address on both deployed contracts.

Once that's done you can send messages both ways using send("Hello World")

Note that you will need to call the send function with some funds by putting a value amount in. I sent 12345678 gwei which seemed to work on testnet and any surplus is refunded back to your wallet. There's an option for this near the gas limit in the top left panel on Remix.

## More Information

I'll do an article and video at some point about cross chain communications.

- https://jamesbachini.com
- https://www.youtube.com/c/JamesBachini
- https://twitter.com/james_bachini
- https://bachini.substack.com