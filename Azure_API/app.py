# app.py

from flask import Flask
from flask_mysqldb import MySQL
from routes import user_routes

app = Flask(__name__)

# Configure MySQL connection
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''  # Add your MySQL password if needed
app.config['MYSQL_DB'] = 'rootx-test'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)

# Register blueprints
app.register_blueprint(user_routes.bp)

if __name__ == '__main__':
    app.run(host='10.11.3.159', port=5000, debug=True)
