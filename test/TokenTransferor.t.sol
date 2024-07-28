// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {TokenTransferor} from "src/TokenTransferor.sol";
import {Helper} from "script/Helper.sol";
import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {LinkTokenInterface} from "@chainlink/contracts/src/interfaces/shared/LinkTokenInterface.sol";
import {IERC20} from
    "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/IERC20.sol";

contract TokenTransferorTest is Test, Helper {
    TokenTransferor public tokenTransferror;
    SupportedNetworks public supportedNetworks;
    // address owner;
    address alice;
    address bob;

    IRouterClient router;
    uint64 destinationChainSelector;
    // LinkTokenInterface linkToken;

    function setUp() public {
        // for each chain pass the Router & link contract address
        alice = makeAddr("alice");
        bob = makeAddr("bob");
    }

    // Send CCIP-BnM from Avalanche Fuji to Ethereum Sepolia
    function test_tranferTokensFromEoaToEoaPayFeesInLink() external {
        uint256 ownerPrivateKey = vm.envUint("PRIVATE_KEY");
        address receiver = address(bob);
        // address receiver = bob;
        // CCIP-BnM
        address tokenToSend = 0xD21341536c5cF5EB1bcb58f6723cE26e8D8E90e4;
        // 0.0000000000000001
        uint256 amount = 100;

        SupportedNetworks source = supportedNetworksMapping["Avalanche Fuji"];
        SupportedNetworks destination = supportedNetworksMapping["Ethereum Sepolia"];

        (address sourceRouter, address linkToken,,) = getConfigFromNetwork(source);
        console.log(sourceRouter);
        // this is
        (,,, uint64 destinationChainId) = getConfigFromNetwork(destination);

        vm.startBroadcast(ownerPrivateKey);

        tokenTransferror = new TokenTransferor(sourceRouter, linkToken);
        tokenTransferror.allowlistDestinationChain(destinationChainId, true);

        LinkTokenInterface(linkToken).transfer(address(tokenTransferror), 1 ether);
        IERC20(tokenToSend).transfer(address(tokenTransferror), amount);

        bytes32 messageId = tokenTransferror.transferTokensPayLINK(destinationChainId, receiver, tokenToSend, amount);

        console.log(
            "You can now monitor the status of your Chainlink CCIP Message via https://ccip.chain.link using CCIP Message ID: "
        );
        console.logBytes32(messageId);

        vm.stopBroadcast();
    }
}
