from base_model import BaseModel

class Recipe(BaseModel):

	# def __init__(self):
	# 	pass

	def get_ingredients(self, recipe):
		sql_command = "SELECT name, sugar, protein, fat, amount from Ingredients JOIN (SELECT ingredient, amount FROM Contains WHERE recipe='{}') AS recipe ON recipe.ingredient = ingredients.id".format(recipe)
		results = self.execute_sql_list(sql_command)
		result_dict = []
		for result in results:
			result_dict.append({
				  "name": result[0],
				  "sugar": result[1],
				  "protein": result[2],
				  "fat": result[3],
				  # In the DB, every amount is per 100g
				  "amount": result[4] * 100,
				})
		return result_dict

	def get_id_from_name_and_author(self, name, author):
		sql_command = "SELECT id FROM Recipes WHERE name='{}' AND author='{}'".format(name, str(author))
		recipe_id = self.execute_and_fetch_one(sql_command)[0]
		return recipe_id

	def new_recipe(self, name, ingredients, author):
		sql_command = "INSERT INTO Recipes (name, author, instruction_file) VALUES ('{}', '{}', '')".format(name, str(author))
		self.execute_sql(sql_command)
		recipe_id = self.get_id_from_name_and_author(name, author)
		# self.execute_sql(sql_command)
		for ingredient in ingredients:
			sql_command = "INSERT INTO Contains (recipe, ingredient, amount, unit) VALUES ('{}', '{}', '{}', '1')".format(recipe_id, ingredient[0], ingredient[1])
			self.execute_sql(sql_command)

	def get_all_recipes(self, userid):
		sql = "SELECT recipes.name, recipes.id, COALESCE( NULLIF(ratings.rating,'0') , '0' ) FROM Recipes LEFT JOIN (SELECT recipe, rating FROM Ratings WHERE userid='{}') AS ratings ON ratings.recipe=recipes.id".format(userid)
		recipes = self.execute_sql_list(sql)

		return recipes

	def get_name(self, recipe_id):
		sql = "SELECT name FROM recipes WHERE id='{}'".format(recipe_id)
		result = self.execute_and_fetch_one(sql)

		if result:
			return result[0]
		else:
			return ""

	def get_popular_recipes(self, num_results=20):
		highest_rated = self.get_highest_rated()
		return highest_rated

	def list_from_ids(self, recipe_ids):
		results = []
		for recipe_id in recipe_ids:
			sql = "SELECT name, id FROM Recipes WHERE id='{}'".format(recipe_id)
			results.append(self.execute_and_fetch_one(sql))
		print results
		return results


	def get_all_ingredients(self):
		sql_command = "SELECT name, id FROM Ingredients"
		results = self.execute_sql_list(sql_command)

		return results

	def get_random_recipes(self, num_results=10):
		sql_command = "SELECT name, id FROM Recipes ORDER BY RANDOM() LIMIT 10"
		results = self.execute_sql_list(sql_command)
		print results
		return results

	def get_highest_rated(self, num_results=6):
		# TODO: Fill in connection to DB through base class.
		sql_command = "SELECT name, id from RECIPES LEFT JOIN (SELECT ratings.recipe, AVG(ratings.rating) as AverageRating FROM Ratings LEFT JOIN Recipes ON ratings.recipe=recipes.id GROUP BY ratings.recipe) as Rankings ON Rankings.recipe = recipes.id LIMIT " + str(num_results)
		results = self.execute_sql_list(sql_command)
		
		result_list = []
		for result in results:
			result_list.append({
				"recipe_name": result[0],
				"recipe_id": result[1]
				})
		print result_list
		return result_list