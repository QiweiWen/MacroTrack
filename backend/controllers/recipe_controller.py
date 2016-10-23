from flask import render_template, request, redirect
from wtforms import Form, BooleanField, StringField, HiddenField, validators

from base_controller import BaseController

from models.recipe import Recipe
import config

class RecipeController(BaseController):
  """Recipe Controller

  Class for a single recipe: creation (POST) and view (GET).
  """

  class RecipeForm(Form):
    """Recipe Form.

    Helper class to wrap wtforms to handle user new recipe form.
    """

    name = StringField('Name', [validators.Length(min=1, max=500), validators.required()])
    ingredients = HiddenField('ingredients', [validators.required()])

  def __init__(self):

  	self.metrics = ["sugar", "fat", "protein"]

  	self.metric_RDI = {
  	  "sugar": config.RDI_SUGAR,
  	  "fat": config.RDI_FAT,
  	  "protein": config.RDI_PROTEIN,
  	}

  def get_ingredients_totals(self, ingredients):

  	ingredients_totals = { "name": "Total RDI" }

  	for metric in self.metrics:
  		ingredients_totals[metric] = 0

  	for ingredient in ingredients:
  		for metric in self.metrics:
  			ingredients_totals[metric] += ingredient[metric]
  	for metric in self.metrics:
  		# Make the total a percentage of the RDI.
	  	ingredients_totals[metric] = str(float(ingredients_totals[metric])/self.metric_RDI[metric])[:4] + "%"
  	
  	return ingredients_totals

  @BaseController.requires_auth
  def get_new_recipe(self):
    data = {
      "ingredients": Recipe().get_all_ingredients(),
      "form": self.RecipeForm(),
      "logged_in": request.user_id
    }
    return render_template("new_recipe.html", data=data)

  def post(self, method=None):
    print request.form
    # Filter out empty strings from ingredient IDs.
    ingredients = filter(len, request.form["ingredients"].split(","))

    ingredient_pairs = []
    for ingredient in ingredients:
      ingredient_pairs.append([ingredient.split("-")[0], ingredient.split("-")[1]])

    name = request.form["name"]
    author = self.get_user_id()
    print ingredients, name, author
    result = Recipe().new_recipe(name, ingredient_pairs, author)
    return redirect("/new/recipe", code=302)

  @BaseController.requires_auth
  def get(self, recipe_id=None, method=None):

    if method == "new_recipe":
      return self.get_new_recipe()

    ingredients = Recipe().get_ingredients(recipe_id)
    ingredients.append(self.get_ingredients_totals(ingredients))

    data = {
      "ingredients": ingredients,
      "recipe_name": Recipe().get_name(recipe_id),
      "logged_in": request.user_id
    }

    return render_template("recipe.html", data=data)

  	