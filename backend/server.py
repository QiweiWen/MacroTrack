from flask import Flask, render_template, session, redirect
from flask_login import LoginManager

from controllers.homepage_controller import HomePageController
from controllers.recipe_controller import RecipeController
from controllers.recipes_controller import RecipesController
from controllers.rating_controller import RatingController
from controllers.user_registration_controller import UserRegistrationController
from controllers.login_controller import LoginController
from controllers.dash_controller import DashController

from models.user import User

app = Flask(__name__)

# HTTP method constants
METHODS = {
	"get": ["GET"],
	"post": ["POST"]
}

def add_route(route_path, route_controller, methods, defaults={}):
  user_view = route_controller.as_view(route_path)
  app.add_url_rule(route_path, view_func=user_view, methods=methods, defaults=defaults)

add_route("/", HomePageController, ["GET"])
add_route("/add/rating", RatingController, ["POST"])
add_route("/recipe/<recipe_id>", RecipeController, ["GET"])
add_route("/recipes", RecipesController, ["GET"])
add_route("/new/recipe", RecipeController, ["GET", "POST"], defaults={"method": "new_recipe"})
add_route("/new/user", UserRegistrationController, ["GET"])
add_route("/register", UserRegistrationController, ["POST"])
add_route("/login", LoginController, ["GET", "POST"])
# add_route("/login", LoginController, ["GET"])
add_route("/dash", DashController, ["GET", "POST"])


if __name__ == '__main__':
  app.secret_key = 'A0Zr98j/3yX R~XHHsdjhljak723&'
  app.run(debug=True)
