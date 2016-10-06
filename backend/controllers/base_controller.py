from flask.views import MethodView

class BaseController(MethodView):

	
	def get():
		return "404 not found."

	def post():
		return "404 not found."