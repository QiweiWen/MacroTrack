from base_model import BaseModel

from flask_user import UserMixin
from flask_bcrypt import generate_password_hash, check_password_hash

import config, hashlib

class User(BaseModel, UserMixin):

  def check_auth(self, email, token):
    sql_command = "SELECT id FROM Users WHERE email=\'" + email + "\' AND pwrd=\'" + token + "'"
    return self.execute_and_fetch_one(sql_command)

  @staticmethod
  def hash_password(password):
    return hashlib.sha512(password + config.SALT).hexdigest()
  
  def is_valid_user(self, email, password):
    sql_command = "SELECT * FROM Users WHERE email='{}' AND pwrd='{}'".format(email, password)
    print sql_command
    return self.execute_and_fetch_one(sql_command)

  def id_from_email(self, email):
    sql_command = "SELECT id FROM Users WHERE email='{}'".format(email)
    return self.execute_and_fetch_one(sql_command)[0]

  def get_macro_tracking(self, userid):
    user_attrs = self.get_attrs_from_id(userid)
    REE= int(round(10*user_attrs["weight"]+6.25*user_attrs["height"]-5*user_attrs["age"]))
    if user_attrs["sex"] == 'F':
      REE = REE - 161
    TDEE = int(round(REE * user_attrs["exercise"]))
    calories = TDEE
    protein_g = user_attrs["weight"] * 1.1
    protein_cal=int(protein_g*4)
    fat_cal=int(0.25*calories)
    fat_g=int(fat_cal/9)
    carbs_cal=int(calories-protein_cal-fat_cal)
    carbs_g=int(carbs_cal/4)
    return {
      "calories": calories,
      "protein": protein_g,
      "fat": fat_g,
      "sugar": 30
    }


  def get_attrs_from_id(self, userid):
    sql = "SELECT sex, height, weight, age, exercise FROM userattr WHERE userid='{}'".format(userid)
    results = self.execute_and_fetch_one(sql)
    return {
      "sex": results[0],
      "height": results[1],
      "weight": results[2],
      "age": results[3],
      "exercise": results[4]
    }

  def new_user(self, new_user_params):
    pass_hash = User.hash_password(new_user_params["password"])
    sql_command = "INSERT INTO Users (name, pwrd, email) VALUES (\'"+new_user_params["username"]+"\', \'"+pass_hash+"\', \'"+new_user_params["email"]+"\')"
    
    self.execute_sql(sql_command)
    user_id = self.id_from_email(new_user_params["email"])
    sql = "INSERT INTO Userattr (userid, sex, height, weight, age, exercise) VALUES ('{}', '{}', '{}', '{}', '{}', '{}')".format(user_id, new_user_params["sex"], new_user_params["height"], new_user_params["weight"], new_user_params["age"], new_user_params["exercise"])
    print sql
    self.execute_sql(sql)

    return True
