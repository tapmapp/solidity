RecipesMenu = () => {

    function createRecipesMenu(recipes) {
        console.log(recipes);
        var recipesListHTML = '<ul>';
        if (recipes.length) {
            recipes.forEach(recipe => recipesListHTML += `<li>${recipe}</li>`);
        } else {
            recipesListHTML += '<li>Not recipes found</li>';
        }
        recipesListHTML += '</ul>';
        document.getElementById('menu-container').innerHTML = recipesListHTML;
    }

    return {
        createRecipesMenu
    }

}
