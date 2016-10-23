from flask import render_template, request, redirect
from wtforms import Form, BooleanField, StringField, PasswordField, validators, IntegerField
from werkzeug import MultiDict

from base_controller import BaseController

from models.user import User
import config

class UserRegistrationController(BaseController):

  class FormData(dict):
    """
    http://stackoverflow.com/questions/4534115/wtforms-doesnt-validate-no-errors/4773452#4773452
    """
    def getlist(self, key):
      v = self[key]
      if not isinstance(v, (list, tuple)):
        v = [v]
      return v


  class RegisterForm(Form):
    """Register Form.

    Helper class to wrap wtforms to handle user reg web form.
    """

    username = StringField('Username', [validators.Length(min=4, max=25)])
    email = StringField('Email Address', [validators.Email(message="Enter valid email")])
    password = PasswordField('New Password', [
        validators.DataRequired(),
        validators.EqualTo('confirm', message='Passwords must match')
    ])
    sex = StringField('Sex (M or F)', [validators.Length(min=1, max=1), validators.AnyOf(["M", "F"])])
    height = IntegerField('Height (cm)', [validators.NumberRange(min=40, max=300, message='Valid height is 40-300cm')])
    weight = IntegerField('Weight (kg)', [validators.NumberRange(min=10, max=600, message='Valid weight is 10-600kg')])
    age = IntegerField('Age', [validators.NumberRange(min=1, max=200, message='Valid age is 1-200')])
    exercise = IntegerField('Average Daily Movement: 1-4 (4 is the highest)', [validators.NumberRange(min=1, max=4, message='1-4 Movement')])
    confirm = PasswordField('Repeat Password')
    accept_tos = BooleanField('I accept the TOS', [validators.DataRequired()])

  def post(self):
    data = self.FormData(request.form)
    if not UserRegistrationController.RegisterForm(data).validate():
      form = UserRegistrationController.RegisterForm(data)
      form.validate()
      print form.errors
      return self.get(form)
    result = User().new_user(request.form)

    return redirect("/login", code=302)

  def get(self, form=None):
    if not form:
      form = self.RegisterForm(request.form)
    data = {
      "form": form
    }
    return render_template("register.html", data=data)
