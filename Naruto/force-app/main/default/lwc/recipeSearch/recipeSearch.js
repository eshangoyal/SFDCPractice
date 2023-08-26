import { LightningElement } from "lwc";
import getRandomRecipe from "@salesforce/apex/IG_SpoonacularAPI.getRandomRecipe";
import getRecipeByIngredients from "@salesforce/apex/IG_SpoonacularAPI.getRecipeByIngredients";

export default class RecipeSearch extends LightningElement {
  recipes = [];
  fetchRandomRecipe() {
    getRandomRecipe()
      .then((data) => {
        this.recipes =
          JSON.parse(data) && JSON.parse(data).recipes
            ? JSON.parse(data).recipes
            : [];
      })
      .catch((error) => {
        console.error(error);
      });
  }

  fetchRecipesByIngredients() {
    const ingredients = this.template.querySelector(".ingredient-input").value;
    getRecipeByIngredients({ ingredients })
      .then((data) => {
        this.recipes = JSON.parse(data);
        console.log('this.recipes------->',this.recipes);
        console.log('this.recipesData------->',data);
      })
      .catch((error) => {
        console.error(error);
      });
  }
}