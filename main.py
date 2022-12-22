from app import app
from dbConfig import mysql
from flask import render_template, request, redirect, url_for, session
import MySQLdb.cursors


@app.route('/')
@app.route('/web')
def web():
    return render_template('web.html')
@app.route('/login', methods=['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM userstore WHERE username = %s AND password = %s', (username, password,))
        account = cursor.fetchone()
        if account:
            session['loggedin'] = True
            session['id'] = account['id']
            session['username'] = account['username']
            msg = 'Logged in successfully!'
            return redirect(url_for('home'))
        else:
            msg =  'Tài khoản không tồn tại!' 
    return render_template('login.html', msg = msg)

@app.route('/register', methods =['GET', 'POST'])
def register():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form :
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        role = request.form['role']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM userstore WHERE email = % s', (email, ))
        account = cursor.fetchone()
        if account:
            msg = 'Account already exists !'
            return render_template('register.html', msg = msg)
        else:
            cursor.execute('INSERT INTO userstore VALUES (NULL, % s, % s, % s,% s)', (username, password, email,role))
            mysql.connection.commit()
            msg = 'You have successfully registered !'
            return redirect(url_for('login'))
    elif request.method == 'POST':
        msg = 'Please fill out the form !'
    return render_template('register.html', msg = msg)

@app.route('/logout')
def logout():
   session.pop('loggedin', None)
   session.pop('id', None)
   session.pop('username', None)
   return redirect(url_for('web'))

@app.route('/nurse')
def home():
    if 'loggedin' in session:
        return render_template('nurse.html', username=session['username'])


@app.route('/patients')
def patients():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM patients")
    patients = cursor.fetchall()
    return render_template('patients.html', patients=patients)

@app.route('/createpatient', methods=['GET', 'POST'])
def create_patient():
    if request.method == 'POST':
        details = request.form
        id = details['id']
        cic_id = details['cic_id']
        pname = details['pname']
        age = details['age']
        Gender = details['Gender']
        tbed = details['tbed']
        address = details['address']
        phone_number = details['phone_number']
        status = details['status']
        cursor = mysql.connection.cursor()
        cursor.execute(
            "INSERT INTO patients(id, cic_id, pname,age,Gender,tbed,address,phone_number,status) VALUES(%s, %s, %s,%s,%s,%s,%s,%s)", (id, cic_id, pname,age,Gender,tbed,address,phone_number,status))
        mysql.connection.commit()
        cursor.close()
        return redirect(url_for('patients'))

    return render_template('createPatients.html')

@app.route('/prescription')
def prescription():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM medicines")
    prescription = cursor.fetchall()
    return render_template('prescription.html',medicines =prescription)

@app.route('/medicinestore')
def medicinestore():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM medicinemaster")
    medicines = cursor.fetchall()
    return render_template('medicinesStore.html',medicinemaster =medicines)

@app.route('/diagnostics')
def diagnostics():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM diagnostics")
    diagnostics = cursor.fetchall()
    return render_template('diagnostics.html',diagnostics =diagnostics)

@app.route('/listofdiagnostics')
def listofdiagnostics():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM diagnosticsmaster")
    listofdiagnostics = cursor.fetchall()
    return render_template('listofdiagnostics.html',diagnosticsmaster =listofdiagnostics)

if __name__ == "__main__":
    app.run()