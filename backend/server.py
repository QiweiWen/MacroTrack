from flask import Flask, render_template
from flask_login import LoginManager

from controllers.homepage_controller import HomePageController
from controllers.recipe_controller import RecipeController
from controllers.user_registration_controller import UserRegistrationController

from models.user import User

app = Flask(__name__)

# Login manager init.
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view =  "signin"

# HTTP method constants
METHODS = {
	"get": ["GET"],
	"post": ["POST"]
}

def add_route(route_path, route_controller, methods):
  user_view = route_controller.as_view(route_path)
  app.add_url_rule(route_path, view_func=user_view, methods=methods)

@login_manager.user_loader
def load_user(id):
    return User.get_user(int(id))

add_route("/", HomePageController, ["GET"])
add_route("/recipe/<recipe_id>", RecipeController, ["GET"])
add_route("/new/user", UserRegistrationController, ["GET"])
add_route("/register", UserRegistrationController, ["POST"])




if __name__ == '__main__':
  app.run(debug=True)