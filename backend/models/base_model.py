import psycopg2
import getpass

class BaseModel():

	def __init__(self):
		# Create connection to the postgres db (library?)
		
		# Get name of user from kernel.
		self.sys_username = getpass.getuser()

		# Connect to postgres db.
		self.db_conn = psycopg2.connect("dbname=MacroTrack user={}".format(self.sys_username))

	def execute_sql(self, command):
		cur = self.db_conn.cursor()
		cur.execute(command)
		
		return cur

	def execute_sql_list(self, command):
		result = self.execute_sql(command)
		
		return result.fetchmany()