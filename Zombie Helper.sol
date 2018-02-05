pragma solidity 0.4.19;

import "./zombieFeeding.sol";

contract ZombieHelper is ZombieFeeding {

//-----------------------------------------------------------------------------------------------------------
//32. 	
	
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
//28. Create a function "changeName" is should take 2 arguments _zombieId and _newName, it should also have the 
//modifier function and take 2 for the _level parameter.
//28.1 make sure that the function verifys that msg.sender is equal to zombieToOwner[_zombieId], then the function
//should set zombieToOwner[_zombieId] equal to _newName.
//-----------------------------------------------------------------------------------------------------------

function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

//-----------------------------------------------------------------------------------------------------------
// 28.2 Create another new function called "changeDna" it should be exactly the same as the "changeName" function
//expect the second argument should be _newDna and it should pass 20 for the _level parameter, and it should set the
//zombies dna to _newDna.
//-----------------------------------------------------------------------------------------------------------

function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
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