const hre = require("hardhat");

async function main() {
  const CertificateIssuer = await hre.ethers.getContractFactory("CertificateIssuer");
  const certificateIssuer = await CertificateIssuer.deploy();

  await certificateIssuer.deployed();

  console.log("CertificateIssuer deployed to:", certificateIssuer.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
