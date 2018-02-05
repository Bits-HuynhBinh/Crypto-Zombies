pragma solidity 0.4.19;

import "./zombieFeeding.sol";

contract ZombieHelper is ZombieFeeding {

//-----------------------------------------------------------------------------------------------------------
///32. Define a uint called "levelUpFee" and set it equal to 0.001 ether.
//-----------------------------------------------------------------------------------------------------------

uint levelUpFee = 0.001 ether;
	
//-----------------------------------------------------------------------------------------------------------
//27. Create a modifier function called aboveLevel, it will take 2 arguments level and _zombieId.
//27.1 the body of the function should check that zombies[_zombieId].level is greater or equal to _level, make sure 
//the function ends with _; as its a modifier.
//-----------------------------------------------------------------------------------------------------------

modifier aboveLevel( uint _level, uint _zombieId) {
	require(zombies[_zombieId].level >= _level);
	_;
}

//-----------------------------------------------------------------------------------------------------------
///33. Create withdraw function that is ownable able and where the function call is external.
//-----------------------------------------------------------------------------------------------------------

function withdraw() external onlyOwner {
	owner.transfer(this.balance);
}

//-----------------------------------------------------------------------------------------------------------
///33.1 Create a function called setLevelUpFee, it will take 1 parameter and will be external with onlyOwner modifier.
//-----------------------------------------------------------------------------------------------------------
function setLevelUpFee(uint _fee) external onlyOwner {
	levelUpFee = _fee;
}

//-----------------------------------------------------------------------------------------------------------
//34. Create new contract called zombieBattle and inherit ZombieHelper.
//-----------------------------------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------------------
///32.1 Create a external payable function called levelUp, it should require msg.value is equal to levelUpFee.
/// and should increment zombies level.
//-----------------------------------------------------------------------------------------------------------

    function levelUp(uint _zombieId) external payable {
	require(msg.value == levelUpFee);
	zombies[_zombieId].level++;
}

//-----------------------------------------------------------------------------------------------------------
//28. Create a function "changeName" is should take 2 arguments _zombieId and _newName, it should also have the 
//modifier function and take 2 for the _level parameter.
//28.1 make sure that the function verifys that msg.sender is equal to zombieToOwner[_zombieId], then the function
//should set zombieToOwner[_zombieId] equal to _newName.
//-----------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------
///38. Change function so that it use's ownerOf(_zombieId) modifier. also remove require statement.
//-----------------------------------------------------------------------------------------------------------

function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) ownerOf(_zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

//-----------------------------------------------------------------------------------------------------------
// 28.2 Create another new function called "changeDna" it should be exactly the same as the "changeName" function
//expect the second argument should be _newDna and it should pass 20 for the _level parameter, and it should set the
//zombies dna to _newDna.
//-----------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------
///38.1 Change function so that it use's ownerOf(_zombieId) modifier. also remove require statement. 
/// go back to zombieAttack contract for step 39.
//-----------------------------------------------------------------------------------------------------------

function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) ownerOf(_zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

//-----------------------------------------------------------------------------------------------------------
//29. Create a function called "getZombiesByOwner" it will take one argument and make it an external view, 
//so it can be called from web3.js, which will allow the function the called without using gas. and it should
// also return a uint[]
//----------------------------------------------------------------------------------------------------------- 
//-----------------------------------------------------------------------------------------------------------
//30. Declare a uint[] memory variable called result. and set it equal to a new uint array where the result 
// should be the the number of zombies a owner has.
//30.1 end the function by returning the result.
//-----------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------
///31. Write a loop in the getZombiesByOwner function, that iterates through all the zombies in the DAPP that 
///compares owners to see if they match and then push them to the result array before returning it.
//-----------------------------------------------------------------------------------------------------------

function getZombiesByOwner(address _owner) external view returns (uint[]) {
	uint[] memory result = new uint[](ownerZombieCount[_owner]);
	uint counter = 0;
	for (uint i = 0; i < zombies.length, i++); {
	if (zombieToOwner[i] = _owner) {
	result[counter] = i;
	counter++;
	}
	}
	return result;
}
}