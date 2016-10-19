# This script is for OSX. Linux just use apt-get.
# Install pip
sudo easy_install pip
sudo apt-get install pip

# Install flask web framework.
sudo pip install flask
sudo pip install psycopg2

# Open the website after 5 seconds.
$(sleep 4; open http://localhost:5000) &

# Start the server.
python server.py
