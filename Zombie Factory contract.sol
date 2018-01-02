//--------------------------------------------------------------------------------------------------------------------
Zombie Factory contract

this is the code for cryptoZombies with step by step instructions to each lesson. Each step of a lesson is put into decimal sections i.e (//1. //1.1 and ///0.1.1).  

numbers //1. and above are the steps that had to be followed for writing the code.
numbers with //0.1, 0.2 etc are parts of a step or instruction   
/// means that a peice of the code was added, changed or modified due to new functions calls or events. 

part one is - //1. to //8.
part two is - //9. to //18.
//--------------------------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------------------------
//1. Enter solidity version here (Compiler version should always be at the top of the page)
//--------------------------------------------------------------------------------------------------------------------

pragma soldity ^0.4.19;

//--------------------------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------------------------
//2. Create contract.
//--------------------------------------------------------------------------------------------------------------------

contract ZombieContract {

//--------------------------------------------------------------------------------------------------------------------
///0.8.1 Declare an event.
//--------------------------------------------------------------------------------------------------------------------        
        event NewZombie(uint _ZombieId, string _name, uint _dna);

//--------------------------------------------------------------------------------------------------------------------
//3. state variable declaration (dnaModulus is 10^16).
//--------------------------------------------------------------------------------------------------------------------
         
         uint dnaDigits = 16;
         uint dnaModulus = 10 ** dnaDigits;

//--------------------------------------------------------------------------------------------------------------------
//4: Create struct for Zombie.
//--------------------------------------------------------------------------------------------------------------------         
         struct Zombie {
         string name;
         uint dna;
         }

//--------------------------------------------------------------------------------------------------------------------
//5. Create array for zombies (Dynamic).
//--------------------------------------------------------------------------------------------------------------------

        Zombie[] public zombies;

//--------------------------------------------------------------------------------------------------------------------
//9. Create 2 mappings to store ownership of the Zombies. 1st mapping is too see which address owns what zombie. 2nd
     mapping is too keep track of how many zombies a owner has. 
//--------------------------------------------------------------------------------------------------------------------

        mapping (uint => address) public zombieToOwner;
        mapping (address => uint) ownerZombieCount;            

//--------------------------------------------------------------------------------------------------------------------
//6. Create function declaration.                                                                                   //6.1 add new zombie to array (.push)
//6.2 make function private.
//--------------------------------------------------------------------------------------------------------------------  
          ///0.8.2 line 72 was "zombies.push(Zombie(_name, _dna));" but changed because of event declaration(0.8.1), function will now store the invokation of the array in (uint) id to allow for the call of NewZombie.
//--------------------------------------------------------------------------------------------------------------------  
//10.0 We update _createZombie function to be able to assign ownership of zombies to a msg.sender. also we increase  the ownerZombieCount for the msg.sender by using [++].           
//--------------------------------------------------------------------------------------------------------------------

         function _createZombie(string _name, uint_dna) internal {     (/// function argument was (private) at start.)
         uint id = zombies.push(Zombie(_name, _dna)) - 1;
         zombieToOwner[id] = msg.sender;
         ownerZombieCount[msg.sender] ++;
         NewZombie(id, _name, _dna); 
      
        }

//--------------------------------------------------------------------------------------------------------------------
//7. Create private function declaration with return, function will need to look at some variables.                 //7.1 make the function return with a random uint (keccak256) % dnaModulus.
//--------------------------------------------------------------------------------------------------------------------

            function _generateRandomDna(string _str) private view returns (uint) {
            uint rand = uint(keccak256(_str)); 
            return rand % dnaModulus;  

        }

//---------------------------------------------------------------------------------------------------------------------
//8. Create a public function declaration. 
//---------------------------------------------------------------------------------------------------------------------
//11. We use a require statement to make sure that the createRandomZombie function can only be called once by a msg.sender. it also has to check that the zombie Value of msg.sender is >> 0 <<.
//---------------------------------------------------------------------------------------------------------------------

         function createRandomZombie(string _name) public {
         require(ownerZombieCount[msg.sender] == 0);           
         uint randDna = _generateRandomDna(_name);
         _createZombie(_name, randDna);
         }        


}

//--------------------------------------------------------------------------------------------------------------------
//12. Create a new contract but make sure you inherit the ZombieFactory contract so you can call the functions. when contract is created in zombieFactory UI the code splits into 2 files. go to "zombieFeeding.sol" for the second part of the zombific training.

For //12. we have to create a new contract go to "zombieFeeding.sol" file, to access the contract.
//---------------------------------------------------------------------------------------------------------------------
