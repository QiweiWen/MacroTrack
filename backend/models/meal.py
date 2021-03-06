from base_model import BaseModel

import config, hashlib

class Meal(BaseModel):
  """Meal

  Model for the mealplan 'Meal'.
  """

  def new_meal(self, author, recipe, meal_type):
    self.remove_meal(author, None, mealcode=meal_type)
    sql_command = "INSERT INTO Mealplan (userid, recipeid, mealcode, dateadded) VALUES ('{}', '{}', '{}', (SELECT now FROM CURRENT_TIMESTAMP))".format(author, recipe, meal_type)
    print sql_command
    return self.execute_sql(sql_command)

  def get_meal_nutrients(self, userid):
    sql = ["SELECT ingredient_amounts.amount, ingredients.sugar, ingredients.fat, ingredients.protein, ingredients.calories FROM ingredients JOIN ",
          "(SELECT ingredient, amount FROM contains JOIN (SELECT recipeid FROM mealplan WHERE dateadded > now() - interval '1 day' AND userid='{}') as mealplan",
          " ON mealplan.recipeid = contains.recipe)",
          " AS ingredient_amounts ON ingredient_amounts.ingredient = ingredients.id"
          ]
    sql = "".join(sql).format(userid)
    nutrient_amounts = self.execute_sql_list(sql)
    results = {
      "sugar": 0,
      "fat": 0,
      "protein": 0,
      "calories": 0
    }
    for ingredient in nutrient_amounts:
      print ingredient
      # 0.25 is bc all recipes are 4 servings
      results["sugar"] += ingredient[0] * 0.25 * ingredient[1]
      results["fat"] += ingredient[0] * 0.25 * ingredient[2]
      results["protein"] += ingredient[0] * 0.25 * ingredient[3]
      results["calories"] += ingredient[0] * (1/17.0) * ingredient[4]

    return results

  def get_all_past_meals(self, userid):
    sql = [
      "SELECT recipes.name, recipes.id, mealplan.mealcode FROM Recipes JOIN",
      " (SELECT recipeid, mealcode FROM mealplan WHERE dateadded < now() - interval '1 day' AND userid='{}' ORDER BY dateadded, mealcode) ".format(userid),
      "AS mealplan on mealplan.recipeid=recipes.id"
    ]
    sql = "".join(sql)
    results = self.execute_sql_list(sql)

    return results

  def remove_meal(self, userid, recipeid, mealcode=None):
    if mealcode:
      sql = "DELETE FROM mealplan WHERE dateadded > now() - interval '1 day' AND userid='{}' AND mealcode='{}'".format(userid, mealcode)
    else:
      sql = "DELETE FROM mealplan WHERE dateadded > now() - interval '1 day' AND userid='{}' AND recipeid='{}'".format(userid, recipeid)

    results = self.execute_sql(sql)
    return results


  def get_daily_meals(self, userid):
    sql = [
      "SELECT recipes.name, recipes.id, mealplan.mealcode FROM Recipes JOIN",
      " (SELECT recipeid, mealcode FROM mealplan WHERE dateadded > now() - interval '1 day' AND userid='{}') ".format(userid),
      "AS mealplan on mealplan.recipeid=recipes.id"
    ]
    sql = "".join(sql)
    results = self.execute_sql_list(sql)

    return results