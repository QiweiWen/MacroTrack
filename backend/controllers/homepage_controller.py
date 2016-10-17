from flask import render_template
from base_controller import BaseController

from models.recipe import Recipe

class HomePageController(BaseController):

  # @staticmethod
  def get(self):
  	data = {
  	  # list of dicts with keys: recipe name, recipe id
  	  "recipes": Recipe().get_popular_recipes(),
      "logged_in": self.is_logged_in()
  	}

  	return render_template("index.html", data=data)

