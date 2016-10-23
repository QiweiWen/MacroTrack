from base_model import BaseModel
from recommender import Recommender

from flask_user import UserMixin
from flask_bcrypt import generate_password_hash, check_password_hash

import config, hashlib

class Rating(BaseModel, UserMixin):

  def new_rating(self, user, recipe, rating):
    sql = "SELECT * FROM Ratings WHERE recipe='{}' AND userid='{}'".format(recipe, user)
    if self.execute_and_fetch_one(sql):
      sql = "DELETE FROM Ratings WHERE recipe='{}' AND userid='{}'".format(recipe, user)
      self.execute_sql(sql)
    sql = sql_command = "INSERT INTO Ratings (userid, recipe, rating) VALUES ('{}', '{}', '{}')".format(str(user), str(recipe), str(rating))
    self.execute_sql(sql) 

    rec = Recommender()
    rec.update_rating(user, recipe, rating)
    rec.switch_model()




