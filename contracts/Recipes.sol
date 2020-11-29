// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Recipes {
  
  address owner;

  struct Step {
    bytes32 id;
    string desc;
  }

  struct Ingredient {
    bytes32 id;
    string name;
    string amount;
    Unit unit;
  }

  struct Recipe { 
    bytes32 id;
    string name;
    uint256 createdAt;
    bool available;
    string picture;
    bytes32[] steps;
    bytes32[] ingredients;
  }

  enum Unit { liter, mililiter, grams, miligram, kilograms, pound, ounce }

  bytes32[] private recipesIds;
  mapping(bytes32 => Recipe) private recipes;

  bytes32[] private ingredientsIds;
  mapping(bytes32 => Ingredient) private ingredients;

  bytes32[] private stepsIds;
  mapping(bytes32 => Step) private steps;

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  constructor() public {
    owner = msg.sender;
  }

  event RecipeAdded(bytes32 id, bool success);
  event IngredientAdded(bytes32 id, bool success);
  event StepAdded(bytes32 id, bool success);

  function getRecipe(bytes32 _recipeId) public view returns(bytes32, uint256, string memory name) {
    require(recipes[_recipeId].available, "The story doesn't exist!");
    return (_recipeId, recipes[_recipeId].createdAt, recipes[_recipeId].name);
  }

  function getRecipesIds() public view returns(bytes32[] memory ids) {
    return recipesIds;
  }

  function createRecipe(string memory _name) public onlyOwner {
    require(bytes(_name).length > 0, "The member's name cannot be empty!");
    
    bytes32 blockHash = blockhash(block.number - 1);
    bytes32 id = keccak256(abi.encodePacked(msg.sender, _name, block.timestamp, blockHash));

    bytes32[] memory _steps;
    bytes32[] memory _ingredients;
    string memory _picture;

    recipes[id] = Recipe({
        id: id,
        name: _name,
        createdAt: block.timestamp,
        available: true,
        picture: _picture,
        steps: _steps,
        ingredients: _ingredients
    });
    recipesIds.push(id);
    
    emit RecipeAdded(id, true);

  }

  function createIngredient(string memory _name, string memory _amount, Unit _unit) public onlyOwner {
    require(bytes(_name).length > 0, "The ingredient name cannot be empty!");
    
    bytes32 blockHash = blockhash(block.number - 1);
    bytes32 id = keccak256(abi.encodePacked(msg.sender, _name, block.timestamp, blockHash));

    ingredients[id] = Ingredient({
      id: id,
      name: _name,
      amount: _amount,
      unit: _unit
    });
    ingredientsIds.push(id);
    
    emit IngredientAdded(id, true);

  }

  function createStep(string memory _desc) public onlyOwner {
    require(bytes(_desc).length > 0, "The description cannot be empty!");
    
    bytes32 blockHash = blockhash(block.number - 1);
    bytes32 id = keccak256(abi.encodePacked(msg.sender, _desc, block.timestamp, blockHash));

    steps[id] = Step({
      id: id,
      desc: _desc
    });
    stepsIds.push(id);
    
    emit StepAdded(id, true);

  }

}
