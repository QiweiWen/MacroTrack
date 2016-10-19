from flask import render_template, request, redirect
from flask_login import login_user, login_required
from wtforms import Form, BooleanField, StringField, PasswordField, validators
from flask_bcrypt import generate_password_hash

from base_controller import BaseController

from models.user import User
from models.meal import Meal
import config

class DashController(BaseController):

  decorators = [BaseController.requires_auth]

  def __init__(self):
    self.user = User()

    self.meal_map = {
      "1": "Breakfast",
      "2": "Lunch",
      "3": "Dinner"
    }

  def get_daily_meal_nutrients(self):
    user_goals = User().get_macro_tracking(request.user_id)
    meal_nutrients = Meal().get_meal_nutrients(request.user_id)
    user_macros = { x: float(meal_nutrients[x])/user_goals[x] * 100 for x in user_goals }
    print user_macros, meal_nutrients
    return user_macros

  def get_daily_meals(self):
    meals = Meal().get_daily_meals(request.user_id)
    meal_list = []
    for meal in meals:
      meal_list.append({
        "name": meal[0],
        "recipeid": meal[1],
        "mealtype": meal[2],
      })
    meal_list = sorted(meal_list, key=lambda k: k["mealtype"])
    results = []
    for meal in meal_list:
      meal["mealtype"] = self.meal_map[str(meal["mealtype"])]
      results.append(meal)
    
    print results
    return results

  def get(self):
    data = {
      "logged_in": True,
      "daily_goals": self.get_daily_meal_nutrients(),
      "meals": self.get_daily_meals()
    }
    return render_template("dash.html", data=data)
