# This script is for OSX. Linux just use apt-get.
# Install pip
sudo easy_install pip
sudo apt-get install pip


# Install flask web framework.
sudo pip install flask
sudo pip install psycopg2

sudo pip install flask-login
sudo pip install flask-user


java -jar getreced.jar CTRL_PIPE STATUS_PIPE RES_PIPE test  > /dev/null &

# Open the website after 5 seconds.
$(sleep 4; open http://localhost:5000) &

# Start the server.
python server.py
