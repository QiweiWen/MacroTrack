from flask import Flask, render_template

from controllers.homepage_controller import HomePageController
from controllers.recipe_controller import RecipeController

app = Flask(__name__)
METHODS = {
	"get": ["GET"],
	"post": ["POST"]
}

def add_route(route_path, route_controller, methods):
  user_view = route_controller.as_view(route_path)
  app.add_url_rule(route_path, view_func=user_view, methods=methods)

add_route("/", HomePageController, ["GET"])
add_route("/recipe/<recipe_id>", RecipeController, ["GET"])


if __name__ == '__main__':
  app.run(debug=True)