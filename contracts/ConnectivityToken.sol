// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract ConnectivityToken is ERC20, Ownable {
    using ECDSA for bytes32;

    struct CoverageData {
        int256 lat;
        int256 long;
        uint256 downloadSpeed;
        uint256 timestamp;
    }

    address public verifierAddress;
    mapping(bytes => bool) public executedSignatures;

    event CoverageVerified(address indexed user, uint256 speed, int256 lat, int256 long);

    constructor(address initialOwner, address _verifierAddress) 
        ERC20("Connectivity Token", "LNK") 
        Ownable(initialOwner)
    {
        verifierAddress = _verifierAddress;
    }

    function setVerifierAddress(address _newVerifier) external onlyOwner {
        verifierAddress = _newVerifier;
    }

    function submitCoverage(
        uint256 speed,
        int256 lat,
        int256 long,
        bytes calldata signature
    ) external {
        require(!executedSignatures[signature], "Signature already used");
        
        // Reconstruct logic: matching the data signed by the Oracle
        // The oracle should sign: keccak256(abi.encodePacked(sender, speed, lat, long))
        bytes32 messageHash = keccak256(abi.encodePacked(msg.sender, speed, lat, long));
        bytes32 ethSignedMessageHash = MessageHashUtils.toEthSignedMessageHash(messageHash);

        address recoveredSigner = ECDSA.recover(ethSignedMessageHash, signature);
        
        require(recoveredSigner == verifierAddress, "Invalid signature");

        executedSignatures[signature] = true;

        // Mint 10 LNK tokens (18 decimals)
        _mint(msg.sender, 10 * 10**decimals());

        emit CoverageVerified(msg.sender, speed, lat, long);
    }
}
