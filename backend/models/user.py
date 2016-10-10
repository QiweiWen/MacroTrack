from base_model import BaseModel

class User(BaseModel):

	@staticmethod
	def get_user(id):
		sql_command = "FROM Users SELECT * WHERE id=" + str(id)
		return self.execute_sql

	def new_user(self, new_user_params):
		sql_command = "INSERT INTO USERS (name, pwrd, email) VALUES ('%s', '%s', '%s')".format(new_user_params["username"], new_user_params["password"], new_user_params["email"])
		return self.execute_sql(sql_command)