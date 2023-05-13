from app import app
import mysql.connector

mysql = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = '',
    database = 'db_new',
    port = 3307
)