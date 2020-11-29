RecipesService = (RecipeContract) => {
    
    async function getRecipes() { await RecipeContract.methods.getRecipesIds().call(); }
    async function getRecipe(recipeId) { await RecipeContract.methods.getRecipe(recipeId).call(); }
    
    return {
        getRecipes,
        getRecipe
    }

}
