from flask import request, redirect
from flask.views import MethodView

from models.user import User
import functools

class BaseController(MethodView):
  """Base Controller

  Base class for all flask controller classes.
  """

  @staticmethod
  def requires_auth(f):
    """Requires auth

    Wrapper funct to block any private routes from non-logged in users.
    """
    @functools.wraps(f)
    def decorated(*args, **kwargs):

      potential_user_id = BaseController().is_logged_in()
      
      if not potential_user_id:
        return redirect("/login", code=302)

      request.user_id = potential_user_id
      return f(*args, **kwargs)

    return decorated

  def get_user_id(self):
    from flask import request
    email = request.cookies.get("email", "")

    return User().id_from_email(email)

  def is_logged_in(self):
    from flask import request
    auth = request.cookies.get("auth_token", "")
    email = request.cookies.get("email", "")
    potential_user_id = User().check_auth(email, auth)

    if potential_user_id:
      return potential_user_id[0]
    else:
      return None

  def get():
    return "404 not found."

  def post():
  	return "404 not found."