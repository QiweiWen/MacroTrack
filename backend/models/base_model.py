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
		print "Executing", command
		result = cur.execute(command)
		self.db_conn.commit()
		return result

	def execute_and_fetch_one(self, command):
		cur = self.db_conn.cursor()
		print "Executing", command
		result = cur.execute(command)
		self.db_conn.commit()
		return cur.fetchone()

	def execute_sql_list(self, command):
		cur = self.db_conn.cursor()
		print "Executing", command
		result = cur.execute(command)
		self.db_conn.commit()
		return cur.fetchall()