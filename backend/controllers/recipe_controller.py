from flask import render_template
from base_controller import BaseController

from models.recipe import Recipe
import config

class RecipeController(BaseController):

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


  def get(self, recipe_id=None):

  	ingredients = Recipe().get_ingredients(recipe_id)
  	ingredients.append(self.get_ingredients_totals(ingredients))

  	data = {
  	  "ingredients": ingredients
  	}
  	
  	return render_template("recipe.html", data=data)

  	