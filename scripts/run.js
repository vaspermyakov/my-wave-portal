const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
  
    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);

    let waveTNX;
    waveTNX = await waveContract.wave();

    let waveCount;
    waveCount = await waveContract.getTotalWaves();

    waveTNX = await waveContract.connect(randomPerson).wave();

    waveCount = await waveContract.getTotalWaves();

    waveTNX = await waveContract.wave();

    let userWaves;
    userWaves = await waveContract.getUserWaves(owner.address);

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