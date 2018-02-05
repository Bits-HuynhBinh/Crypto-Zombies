//-----------------------------------------------------------------------------------------------
//34. define compiler version and import zombieHelper and also create contract.
//-----------------------------------------------------------------------------------------------

Pragma solidity ^0.4.19;

import "./zombieHelper.sol";

contract ZombieBattle is ZombieHelper {

//----------------------------------------------------------------------------------------------
//35. give the contract a uint randNonce equal to 0.
//----------------------------------------------------------------------------------------------
///36. give the contract another uint called attackVictoryProbility equal to 70.
//----------------------------------------------------------------------------------------------

uint randNonce = 0;
uint attackVictoryProbability = 70;



//----------------------------------------------------------------------------------------------
//35.1 Create a function "randMod" it will take one parameter, be a internal function and return a
// uint, body of the function should increment randNonce and then should calculate the uint typecast 
// of keccak256 hash of now, msg.sender and randNonce and return the value % by _modulus.
//----------------------------------------------------------------------------------------------

function randMod(uint _modulus) internal returns (uint) {
	randNonce++;
	return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
}	

//----------------------------------------------------------------------------------------------
//36.1 Create a function called "attack" give it 2 parameters, and will be a external function.
// leave the body empty for now.
//----------------------------------------------------------------------------------------------
///39. Add ownerOf(_zombieId) modifier to the function. Declare a storage pointer for myzombie and for
/// enemyZombie, then declare a uint called rand and the result equal to randMod function with 100 as a argument.
//----------------------------------------------------------------------------------------------
// go to ZombieFactory contract for step 40.
//----------------------------------------------------------------------------------------------
///41. Add a if statement that checks if rand is equal or less than attackVictoryProbability, if the condition is
/// true then increment myzombies, winCount, level and enemyZombie lossCount. then run the feedAndMultiply function from
/// zombieFeeding.sol.
//----------------------------------------------------------------------------------------------
///42. Add a esle statement incase our zombie losses. it will end to increment myZombies lossCount and 
/// increment enemyZombies winCount. then call the _triggerCoolDown function outside of the esle statement.
//----------------------------------------------------------------------------------------------

function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
   Zombie storage myzombie = zombies[_zombieId];
   Zombie storage enemyZombie = zombies[_targetId];
   uint rand = randMod(100);
   if (rand <= attackVictoryProbability) {
      myZombie.winCount++;
      myZombie.level++;
      enemyZombie.lossCount++;
      feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    } 
    else {
    	myZombie.lossCount++;
    	enemyZombie.winCount++;
   
    }

    _triggerCooldown(myZombie);
}

//---------------------------------------------------------------------------------------------
//37. Go to zombieFeeding and create a modifier under kittyInterface.
//---------------------------------------------------------------------------------------------

}