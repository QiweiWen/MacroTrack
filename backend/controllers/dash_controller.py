from flask import render_template, request, redirect
from flask_login import login_user, login_required
from wtforms import Form, BooleanField, StringField, PasswordField, validators

from base_controller import BaseController

from models.user import User
from models.meal import Meal
from models.recommender import Recommender
import config

class DashController(BaseController):
  """Dash Controller

  Controller for the users dashboard, grabs all data about the user's activity.
  """

  decorators = [BaseController.requires_auth]

  def __init__(self):
    self.user = User()

    self.meal_map = {
      "1": "Breakfast",
      "2": "Lunch",
      "3": "Dinner"
    }

  def get_daily_meal_nutrients(self):
    # Func to calculate the macro for user's day.
    user_goals = User().get_macro_tracking(request.user_id)
    meal_nutrients = Meal().get_meal_nutrients(request.user_id)
    user_macros = { x: float(meal_nutrients[x])/user_goals[x] * 100 for x in user_goals }
    print user_macros, meal_nutrients
    return user_macros

  def get_meal_history(self):
    # Grabs all past meals for user
    meals = Meal().get_all_past_meals(request.user_id)
    results = []
    meal_list = []
    for meal in meals:
      meal_list.append({
        "name": meal[0],
        "recipeid": meal[1],
        "mealtype": meal[2],
      })
    for meal in meal_list:
      meal["mealtype"] = self.meal_map[str(meal["mealtype"])]
      results.append(meal)

    return results


  def get_daily_meals(self):
    # Grabs todays mealplan
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

  def get_recommended(self):
    # Talks to the recommender to grab recommendations for this user.
    user_id = request.user_id
    recommendations = Recommender().get_recipes_for_user(user_id)
    print recommendations
    return recommendations

  def get(self):
    if request.args.get('action') == "remove-meal":
      recipe_id = request.args.get('recipe')
      Meal().remove_meal(request.user_id, recipe_id)
      redirect("/dash", code=302)

    data = {
      "logged_in": True,
      "daily_goals": self.get_daily_meal_nutrients(),
      "meals": self.get_daily_meals(),
      "meal_history": self.get_meal_history(),
      "recommended_meals": self.get_recommended()
    }
    return render_template("dash.html", data=data)
