from base_model import BaseModel

class Recipe(BaseModel):

	# def __init__(self):
	# 	pass

	def get_ingredients(self, recipe):
		# sql_command = "SELECT name from Ingredients LEFT JOIN (SELECT ingredient FROM Contains WHERE recipe='0') AS recipe ON recipe.ingredient = ingredients.id"
		# results = self.execute_sql_list(sql_command)
		return [{
			"name": "Cheese, mozzarella, buffalo",
			"sugar": 1318,
			"protein": 0.3,
			"fat": 17.2
		}, {
			"name": "Flour, wheat, white, high protein or bread making flour",
			"sugar": 1492,
			"protein": 0.1,
			"fat": 11.3
		}]

	def get_popular_recipes(self, num_results=20):
		highest_rated = self.get_highest_rated()
		return highest_rated

	def get_highest_rated(self, num_results=20):
		# TODO: Fill in connection to DB through base class.
		sql_command = "SELECT name, id from RECIPES LEFT JOIN (SELECT ratings.recipe, AVG(ratings.rating) as AverageRating FROM Ratings LEFT JOIN Recipes ON ratings.recipe=recipes.id GROUP BY ratings.recipe) as Rankings ON Rankings.recipe = recipes.id"
		results = self.execute_sql_list(sql_command)
		result_dict = {}
		result_list = []
		for result in results:
			result_dict["recipe_name"] = result[0]
			result_dict["recipe_id"] = result[1]
			result_list.append(result_dict)
		print result_list
		return result_list