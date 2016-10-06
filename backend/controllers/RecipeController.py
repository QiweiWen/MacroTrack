from flask import render_template
from base_controller import BaseController

from models.recipe import Recipe

class HomePageController(BaseController):

  @staticmethod
  def get():
  	data = {
  	  "ingredients": Recipe().get_ingredients()
  	}
  	
  	return render_template("index.html", data=data)

  	