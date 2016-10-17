from flask import render_template, request, redirect
from flask_login import login_user, login_required
from wtforms import Form, BooleanField, StringField, PasswordField, validators
from flask_bcrypt import generate_password_hash

from base_controller import BaseController

from models.user import User
import config

class DashController(BaseController):

  decorators = [BaseController.requires_auth]

  def __init__(self):
    self.user = User()

  class RegisterForm(Form):
    """Register Form.

    Helper class to wrap wtforms to handle user reg web form.
    """

    email = StringField('Email Address', [validators.Length(min=6, max=35)])
    password = PasswordField('New Password', [validators.DataRequired()])

  # @BaseController.requires_auth
  def get(self):
    data = {
      "form": self.RegisterForm(),
      "logged_in": True
    }
    return render_template("dash.html", data=data)
