from flask import render_template, request
from wtforms import Form, BooleanField, StringField, PasswordField, validators

from base_controller import BaseController

from models.user import User
import config

class UserRegistrationController(BaseController):

  class RegisterForm(Form):
    """Register Form.

    Helper class to wrap wtforms to handle user reg web form.
    """

    username = StringField('Username', [validators.Length(min=4, max=25)])
    email = StringField('Email Address', [validators.Length(min=6, max=35)])
    password = PasswordField('New Password', [
        validators.DataRequired(),
        validators.EqualTo('confirm', message='Passwords must match')
    ])
    confirm = PasswordField('Repeat Password')
    accept_tos = BooleanField('I accept the TOS', [validators.DataRequired()])

  def post(self):
    result = User().new_user(request.form)
    return result#redirect("/dash", code=302)

  def get(self):
  	data = {
      "form": self.RegisterForm()
    }
  	return render_template("register.html", data=data)

  	