from flask import Flask, render_template


app = Flask(__name__)

@app.route("/")
def get_home_page():

  data = {
  	"recipes": ["pizza", "toastie", "butter chicken", "steak"]
  }
  
  return render_template("index.html", data=data)

if __name__ == '__main__':
  app.run(debug=True)