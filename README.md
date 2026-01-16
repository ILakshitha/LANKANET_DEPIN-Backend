# LankaNet - Decentralized Connectivity Map

LankaNet is a DePIN (Decentralized Physical Infrastructure Network) application that incentivizes users to crowdsource internet speed and connectivity data in Sri Lanka.

## Architecture

The system consists of three main components:

1.  **Frontend (Web App)**:
    -   Built with Next.js 14.
    -   Collects user's internet speed data and GPS location.
    -   Sends unsigned data to the Oracle API for verification.
    -   Submits the signed verification message to the Smart Contract.

2.  **Oracle (API)**:
    -   Hosted as Next.js API Routes.
    -   Verifies the validity of the submitted speed test data.
    -   Cryptographically signs the data payload using an authorized wallet.
    -   Returns the signature to the frontend.

3.  **Smart Contracts**:
    -   Built with Hardhat and Solidity.
    -   Verifies the Oracle's signature on-chain.
    -   Mints crypto reward tokens to the user if the data is valid.

## Directory Structure

-   `/web`: Frontend application and Oracle API.
-   `/contracts`: Smart contracts and deployment scripts.

## Tech Stack

-   **Frontend**: Next.js 14, Tailwind CSS, Lucide React, Viem.
-   **Smart Contracts**: Hardhat, Solidity 0.8.20.


# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```

