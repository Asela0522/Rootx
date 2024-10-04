# routes/__init__.py

from flask import Blueprint

bp = Blueprint('user_routes', __name__)


from .user_routes import *
