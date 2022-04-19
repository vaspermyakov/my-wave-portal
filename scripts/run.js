const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({value: hre.ethers.utils.parseEther("0.1"),});
  await waveContract.deployed();
  console.log("Contract addy:", waveContract.address);

  let waveCount;
  waveCount = await waveContract.getTotalWaves();
  console.log(waveCount.toNumber());

  // Get contract balance
  let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  // Make a wave
  let waveTxn = await waveContract.wave("This is wave #1");
  await waveTxn.wait(); // Wait for the transaction to be mined
  
  waveTNX = await waveContract.wave("This is wave #2");
  await waveTNX.wait();
  // Get contract balance
  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  const [_, randomPerson] = await hre.ethers.getSigners();
  waveTxn = await waveContract.connect(randomPerson).wave("This is wave #3");
  await waveTxn.wait(); // Wait for the transaction to be mined

  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);

  // Get total number of waves
  waveCount = await waveContract.getTotalWaves();

  // Get waves of a specific user
  let userWaves;
  userWaves = await waveContract.getUserWaves(randomPerson.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();