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

  def new_user(self, new_user_params):
    pass_hash = User.hash_password(new_user_params["password"])
    sql_command = "INSERT INTO Users (name, pwrd, email) VALUES (\'"+new_user_params["username"]+"\', \'"+pass_hash+"\', \'"+new_user_params["email"]+"\')"
    #sql_command = "INSERT INTO Users (name, pwrd, email) VALUES ('%s', '%s', '%s')".format(new_user_params["username"], new_user_params["password"], new_user_params["email"])
    return self.execute_sql(sql_command)
