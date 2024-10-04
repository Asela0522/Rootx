# routes/user_routes.py

from flask import Blueprint, request, jsonify
from flask_mysqldb import MySQL
import bcrypt

bp = Blueprint('user_routes', __name__)

# MySQL connection should be configured in app.py for use here
mysql = MySQL()

@bp.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    email = data.get('email')
    username = data.get('username')
    phone = data.get('phone')
    password = data.get('password')

    if not email or not username or not phone or not password:
        return jsonify({'error': 'Please provide all fields!'}), 400

    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM users WHERE email=%s", (email,))
    existing_user = cur.fetchone()

    if existing_user:
        return jsonify({'error': 'User already exists!'}), 400

    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    cur.execute("INSERT INTO users (email, username, phone, password) VALUES (%s, %s, %s, %s)",
                (email, username, phone, hashed_password))
    mysql.connection.commit()
    cur.close()

    return jsonify({'message': 'User registered successfully!'}), 201


@bp.route('/reset_password', methods=['POST'])
def reset_password():
    data = request.get_json()
    email = data.get('email')
    new_password = data.get('new_password')

    if not email or not new_password:
        return jsonify({'error': 'Please provide both email and new password!'}), 400

    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM users WHERE email=%s", (email,))
    existing_user = cur.fetchone()

    if not existing_user:
        return jsonify({'error': 'User not found!'}), 404

    hashed_password = bcrypt.hashpw(new_password.encode('utf-8'), bcrypt.gensalt())

    cur.execute("UPDATE users SET password=%s WHERE email=%s", (hashed_password, email))
    mysql.connection.commit()
    cur.close()

    return jsonify({'message': 'Password reset successful!'}), 200


@bp.route('/signin', methods=['POST'])
def signin():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({'error': 'Please provide both email and password!'}), 400

    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM users WHERE email=%s", (email,))
    user = cur.fetchone()
    cur.close()

    if user is None:
        return jsonify({'error': 'User does not exist!'}), 404

    if bcrypt.checkpw(password.encode('utf-8'), user['password'].encode('utf-8')):
        return jsonify({'message': 'Login successful!', 'user': {
            'email': user['email'],
            'username': user['username'],
            'phone': user['phone']
        }}), 200
    else:
        return jsonify({'error': 'Invalid password!'}), 401
