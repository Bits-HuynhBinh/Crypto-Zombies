pragma solidity ^0.4.19;

//---------------------------------------------------------------------------------------------------------------------
//12. Create a new contract but make sure you inherit the ZombieFactory contract so you can call the functions.
//12.1 At the creation of the new contract, we split the code into 2 files, to access the zombieFactory file we must import the contract using - import "./"
//---------------------------------------------------------------------------------------------------------------------

import "./zombieFactory.sol";

//---------------------------------------------------------------------------------------------------------------------
//16.1 Create a contract interface that returns all the kitties data, from the kittie contract, kitty contract must sit above the inheritation.
//16.2 Define function as it is in the kittie contract. 
//---------------------------------------------------------------------------------------------------------------------

contract kittyInterface {
	function getKitty(uint256 _id) external view returns (
	bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes

  );
}

contract ZombieFeeding is ZombieFactory {

//---------------------------------------------------------------------------------------------------------------------
//16.3 After calling the KittieInterface, add the cryptoKitties contract address, store it in a variable (ckAddress).
//16.4 Create another Interface named KittieContract and initialize it with (ckAddress), no need to call it a contract. 
//---------------------------------------------------------------------------------------------------------------------

      address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
      KittyInterface KittyContract = KittyInterface(ckAddress);

//---------------------------------------------------------------------------------------------------------------------
//13. Create a public function declaration (feedAndMultiply, with two parameters).
//13.1 Add require statement to the function so msg.sender is equal to zombie's owner.
//13.2 After that declare a storage pointer zombie named myZombie, and set the variable equal to [_zombieId] in the zombies Array. 
//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------
//14. This step is how to formulate new dna for a zombie. make function set targetDna equal to targetDna % dnaModulus. 
//14.1 Declare a uint called newDna and set it equal to myZombie's dna and _targetDna.
//14.2 Once new dna is created you need to call the _createZombie function with the (string, and uint) parameterers.
//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------
//18. Add a 3rd arguement to feedAndMultiply (string species) so that the zombies take kitty dna when feeding.
//18.1 After the (species) argument is added you must add an if statement comparing the keccak256 hashes of species and "kitty".
//18.2 Once the if statement is added, we will replace the last two dna digits with "99". (newDna = newDna - newDna % 100 + 99).
//---------------------------------------------------------------------------------------------------------------------
   
    function feedAndMultiply(uint _zombieId, uint _targetDna,string specices) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = _(myZombie.dna + _targetDna) / 2;
    if (keccak256(species) == keccak256("kitty")) {
    newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
    
    } 

//---------------------------------------------------------------------------------------------------------------------	
///15. We must change the _createZombie function from zombieFactory.sol contract, from (private) to (internal), so that the zombieFeeding contract can call the _createZombie function. this is because (private) only allows that contract to call the function but (internal) allows for contracts that inherit the father contract to also call functions from within the father contract.
///15. _createZombie function is on line49 of zombieFactory.sol. (function _createZombie(string _name, uint_dna) private) 
//---------------------------------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------------------------------
//16. Create a interface for our contract to interact with another contract (cyrptoKitties) this must be defined as a contract under the import function. #line8 of this file.
//---------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------
//17. Create a public function declaration, with (2) parameters
//17.1 Then declare a uint for kittyDna
//17.2 Call kittieContract.getKitty function but use getKitty to call the variables of the functions. (remember theres 10 and you only want to use one of them (genes).
//17.3 function will also need to call (feedAndMultiply).
//---------------------------------------------------------------------------------------------------------------------
///18.3 Last part of this step is to change the feedAndMuiltply call in the feedOnKitty function, by adding another parameter ("kitty").
//---------------------------------------------------------------------------------------------------------------------

     function feedOnKitty(uint _zombieId, uint _kittyId) public {
     uint kittyDna;
     (,,,,,,,,,kittyDna) = KittyContract.getKitty(_kittyId);
     feedAndMultiply(_zombieId, kittyDna, "kitty");
     }
}