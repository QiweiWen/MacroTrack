from flask import render_template, request, redirect
from flask_login import login_user, login_required
from wtforms import Form, BooleanField, StringField, PasswordField, validators
from flask_bcrypt import generate_password_hash

from base_controller import BaseController

from models.user import User
from models.recipe import Recipe
import config

class RecipesController(BaseController):

  @BaseController.requires_auth
  def get(self):
    
    data = {
      "recipes": Recipe().get_random_recipes(),
      "logged_in": request.user_id
    }

    print data
    return render_template("recipes.html", data=data)
