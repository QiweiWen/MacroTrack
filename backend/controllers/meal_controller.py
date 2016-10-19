from flask import render_template, request, redirect
from wtforms import Form, BooleanField, StringField, PasswordField, validators

from base_controller import BaseController

from models.user import User
from models.meal import Meal
import config
import json

class MealController(BaseController):

  @BaseController.requires_auth
  def post(self):
    data = json.loads(request.data)
    Meal().new_meal(request.user_id, data["recipe"], data["meal"])

    return json.dumps({ 'success':True }), 200, { 'ContentType':'application/json' }