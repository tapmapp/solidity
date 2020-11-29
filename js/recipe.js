RecipeModule = (RecipeContract, account) => {

    let button = document.getElementById('create-recipe-button');
    let input = document.getElementById('create-recipe');

    button.addEventListener('click', () => {
        createRecipe(input.value, account, 30000);
    });

    createRecipe = async (recipeName, from, gas) => await RecipeContract.methods.createRecipe(recipeName).send({ from, gas });

    return {
        createRecipe
    }

}