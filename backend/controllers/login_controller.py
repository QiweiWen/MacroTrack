from flask import render_template, request, redirect, make_response
from flask_login import login_user
from wtforms import Form, BooleanField, StringField, PasswordField, validators
from flask_bcrypt import generate_password_hash, check_password_hash

from base_controller import BaseController

from models.user import User
import config

class LoginController(BaseController):

  def __init__(self):
    self.user = User()

  class RegisterForm(Form):
    """Register Form.

    Helper class to wrap wtforms to handle user reg web form.
    """

    email = StringField('Email Address', [validators.Length(min=6, max=35)])
    password = PasswordField('New Password', [validators.DataRequired()])

  def post(self):
    form_data = request.form
    password = User.hash_password(form_data["password"])
    if self.user.is_valid_user(form_data["email"], password):
        response = make_response(redirect('/dash', code=302))
        response.set_cookie('auth_token', password)
        response.set_cookie('email', form_data["email"])
        return response
    return redirect("/login", code=302)


  def get(self):
    data = {
      "form": self.RegisterForm()
    }
    return render_template("login.html", data=data)
