from base_model import BaseModel

class User(BaseModel):

	# def __init__(self):
	# 	pass

	def new_user(self, new_user_params):
		highest_rated = self.get_highest_rated()
		return highest_rated