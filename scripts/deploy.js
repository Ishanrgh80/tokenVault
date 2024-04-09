const setWidrawalRole = "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2"
async function main() {

    const [deployer] = await ethers.getSigners();
  
  
    const tokenVault = await ethers.getContractFactory("RBAC");
  
    // Start deployment, returning a promise that resolves to a contract object
    const valut = await tokenVault.deploy(setWidrawalRole);
    console.log("Contract deployed to address:", await valut.getAddress());
  
    console.log("Deployers Address",await deployer.getAddress());
   }
   
   main()
     .then(() => process.exit(0))
     .catch(error => {
       console.error(error);
       process.exit(1);
     });