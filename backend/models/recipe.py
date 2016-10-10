from base_model import BaseModel

class Recipe(BaseModel):

	# def __init__(self):
	# 	pass

	def get_ingredients(self, recipe):
		sql_command = "SELECT name, sugar, protein, fat from Ingredients JOIN (SELECT ingredient FROM Contains WHERE recipe='{}') AS recipe ON recipe.ingredient = ingredients.id".format(recipe)
		results = self.execute_sql_list(sql_command)
		result_dict = []
		for result in results:
			result_dict.append({
				  "name": result[0],
				  "sugar": result[1],
				  "protein": result[2],
				  "fat": result[3],
				})
		return result_dict

	def get_popular_recipes(self, num_results=20):
		highest_rated = self.get_highest_rated()
		return highest_rated

	def get_random_recipes(self, num_results=10):
		sql_command = "SELECT name, id FROM Recipes ORDER BY RANDOM() LIMIT 10"
		results = self.execute_sql_list(sql_command)
		print results
		return results

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