from app import app
from db_config import mysql
from flask import Flask, render_template, request, session, redirect, url_for, send_from_directory
import re



# Trang chủ
@app.route('/')
def home():
    return render_template('home.html')



# Login - Logout - Register
@app.route('/login', methods=['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        cursor = mysql.cursor()
        cursor.execute(
            'SELECT * FROM userstore WHERE username = %s AND password = %s', (username, password,))
        account = cursor.fetchone()
        if account:
            session['loggedin'] = True
            session['id'] = account[0]
            session['username'] = account[1]
            msg = 'Đăng nhập thành công!'
            if str(account[4]) == 'Doctor':
                return redirect(url_for('doctor_main'))
            elif str(account[4]) == 'Nurse':
                return redirect(url_for('nurse_main'))
            else:
                return redirect(url_for('trangchuadmin'))
        else:
            msg = 'Tài khoản không tồn tại!'
    return render_template('login.html', msg=msg)

@app.route('/register', methods=['GET', 'POST'])
def register():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form:
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        role = request.form['role']
        cursor = mysql.cursor()
        cursor.execute('SELECT * FROM userstore WHERE user = % s', (username, ))
        account = cursor.fetchone()
        if account:
            msg = 'Tài khoản đã tồn tại !'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Địa chỉ email không chính xác!'
        elif not re.match(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!#%*?&]+', password):
            msg = 'Mật khẩu phải có chữ hoa, thường, số và ký tự đặc biệt!'
        else:
            cursor.execute('INSERT INTO userstore VALUES (% s, % s, % s,% s)',
                           (username, password, email, role))
            mysql.commit()
            msg = 'Tạo tài khoản thành công !'
            return redirect(url_for('login'))
    elif request.method == 'POST':
        msg = 'Vui lòng điền đầy đủ thông tin !'
    return render_template('register.html', msg=msg)

@app.route('/logout')
def logout():
   session.pop('loggedin', None)
   session.pop('id', None)
   session.pop('username', None)
   return redirect(url_for('home'))


# Admin

@app.route('/trangchuadmin', methods=['GET','POST'])
def trangchuadmin():
    return render_template('display.html')


@app.route('/nhanvien')
def nhanvien():
    cur = mysql.cursor()
    select_info = 'UPDATE data set data.tongsoletan = (SELECT COUNT(staff.id) FROM staff WHERE staff.role="letan")'
    cur.execute(select_info)
    select_info1 = 'UPDATE data set data.tongsobacsi = (SELECT COUNT(staff.id) FROM staff WHERE staff.role="doctor")'
    cur.execute(select_info1)
    select_info2 = 'select * from data'
    cur.execute(select_info2)
    nhanvien = cur.fetchall()
    return render_template('nhanvien.html', nhanvien = nhanvien)

@app.route('/danhsachnhanvien')
def danhsachnhanvien():
    cur = mysql.cursor()
    select_info = 'select * from staff'
    cur.execute(select_info)
    danhsachnhanvien = cur.fetchall()
    return render_template('danhsachnhanvien.html', danhsachnhanvien = danhsachnhanvien)

@app.route("/bieudonhanvien")
def bieudonhanvien():
    return render_template('bieudonhanvien.html')


@app.route('/bieudobenhnhan')
def bieudobenhnhan():
    return render_template('benhnhangiuongcot.html')

@app.route('/thongkebenhnhan')
def thongkebenhnhan():
    cur = mysql.cursor()
    select_info = 'UPDATE thongkebenhnhan set thongkebenhnhan.nam = (SELECT COUNT(pid) FROM patients WHERE patients.Gender="male")'
    cur.execute(select_info)
    select_info1 = 'UPDATE thongkebenhnhan set thongkebenhnhan.nu = (SELECT COUNT(pid) FROM patients WHERE patients.Gender="female")'
    cur.execute(select_info1)
    select_info2 = 'UPDATE thongkebenhnhan set thongkebenhnhan.p1 = (SELECT COUNT(pid) from patients WHERE patients.tbed="Single Room")'
    cur.execute(select_info2)
    select_info3 = 'UPDATE thongkebenhnhan set thongkebenhnhan.p3 = (SELECT COUNT(pid) from patients WHERE patients.tbed="General Ward")'
    cur.execute(select_info3)
    select_info4= 'UPDATE thongkebenhnhan set thongkebenhnhan.p2 = (SELECT COUNT(pid) from patients WHERE patients.tbed="Semi Sharing")'
    thongkebenhnhan = cur.fetchall()
    return render_template('thongkebenhnhan.html', thongkebenhnhan = thongkebenhnhan)

@app.route('/quantriduocpham')
def quantriduocpham():
    cur = mysql.cursor()
    select_info = 'SELECT * FROM medicinemaster order by medicinemaster.price '
    cur.execute(select_info)
    quantriduocpham= cur.fetchall()
    return render_template('quantriduocpham.html', quantriduocpham = quantriduocpham)

@app.route('/quantribenhnhan')
def quantribenhnhan():
    cur = mysql.cursor()
    select_info = 'SELECT * FROM patients'
    cur.execute(select_info)
    quantribenhnhan= cur.fetchall()
    return render_template('quantribenhnhan.html', quantribenhnhan = quantribenhnhan)













#Doctor
@app.route('/doctor')
def doctor_main():
    return render_template('doctor_main.html', doctor_main = doctor_main)

@app.route('/thongtincanhan')
def thongtincanhan():
    cur = mysql.cursor()
    select_info = "SELECT * FROM staff where staff.id = %(temp)s "
    cur.execute(select_info, {'temp': session['id']})
    thongtincanhan = cur.fetchall()
    return render_template('thongtincanhan.html', thongtincanhan = thongtincanhan)
@app.route('/ravien')
def ravien():
    cur = mysql.cursor()
    select_info = "SELECT * FROM patients JOIN userstore ON patients.bsi_id = userstore.id where userstore.id = %(temp)s and patients.status = 'Discharged' order by patients.pid"
    cur.execute(select_info, {'temp': session['id']} )
    ravien = cur.fetchall()
    return render_template('ravien.html', ravien = ravien)

@app.route('/namvien')
def namvien():
    cur = mysql.cursor()
    select_info = "SELECT * FROM patients JOIN userstore ON patients.bsi_id = userstore.id where userstore.id = %(temp)s and patients.status = 'Active' order by patients.pid "
    cur.execute(select_info, {'temp': session['id']} )
    namvien = cur.fetchall()
    return render_template('namvien.html', namvien = namvien)

@app.route('/lichlamviec', methods=['GET'])
def lichlamviec():
    return redirect(url_for('static', filename='/dist/index.html'))

@app.route('/danhsachbenh')
def danhsachbenh():
    return render_template('dsbenh.html')

@app.route('/donthuocmoi', methods=['GET', 'POST'])
def donthuocmoi():
    if request.method == 'POST':
        details = request.form
        pid = details['pid']
        mname = details['mname']
        mid = details['mid']
        price = details['price']
        quantity = details['quantity']
        cursor = mysql.cursor()
        cursor.execute(
            "INSERT INTO medicines(pid, mname,mid,price,quantity) VALUES(%s, %s,%s,%s,%s)", (pid, mname,mid,price,quantity))
        mysql.commit()
        cursor.close()
        return redirect(url_for('donthuoc'))
    return render_template('donthuocmoi.html')

@app.route('/chuandoanmoi', methods=['GET', 'POST'])
def chuandoanmoi():
    if request.method == 'POST':
        details = request.form
        pid = details['pid']
        tname = details['tname']
        tid = details['tid']
        dprice = details['dprice']
        cursor = mysql.cursor()
        cursor.execute(
            "INSERT INTO diagnostics(pid, tname,tid,dprice) VALUES(%s, %s,%s,%s)", (pid, tname,tid,dprice))
        mysql.commit()
        cursor.close()
        return redirect(url_for('chuandoanbenhnhan'))
    return render_template('chuandoanmoi.html')
    





#letan
@app.route('/nurse')
def nurse_main():
   if 'loggedin' in session:
        return render_template('nurse_main.html',nurse_main=nurse_main, username=session['username'])

@app.route('/danhsachbenhnhan')
def danhsachbenhnhan():
    cursor = mysql.cursor()
    cursor.execute("SELECT * FROM patients")
    danhsachbenhnhan = cursor.fetchall()
    return render_template('danhsachbenhnhan.html', patients=danhsachbenhnhan)

@app.route('/thembenhnhanmoi', methods=['GET', 'POST'])
def thembenhnhanmoi():
    if request.method == 'POST':
        details = request.form
        cic_id = details['cic_id']
        pname = details['pname']
        age = details['age']
        Gender = details['Gender']
        tbed = details['tbed']
        address = details['address']
        phone_number = details['phone_number']
        status = details['status']
        cursor = mysql.cursor()
        cursor.execute(
            "INSERT INTO patients(cic_id, pname,age,Gender,tbed,address,phone_number,status) VALUES(%s, %s,%s,%s,%s,%s,%s,%s)", (cic_id, pname, age, Gender, tbed, address, phone_number, status))
        mysql.commit()
        cursor.close()
        return redirect(url_for('danhsachbenhnhan'))
    return render_template('thembenhnhanmoi.html')

@app.route('/donthuoc')
def donthuoc():
    cursor = mysql.cursor()
    cursor.execute("SELECT * FROM medicines")
    donthuoc = cursor.fetchall()
    return render_template('donthuoc.html', medicines=donthuoc)


@app.route('/danhsachcacloaithuoc')
def danhsachcacloaithuoc():
    cursor = mysql.cursor()
    cursor.execute("SELECT * FROM medicinemaster")
    danhsachcacloaithuoc = cursor.fetchall()
    return render_template('danhsachcacloaithuoc.html', medicinemaster=danhsachcacloaithuoc)


@app.route('/chuandoanbenhnhan')
def chuandoanbenhnhan():
    cursor = mysql.cursor()
    cursor.execute("SELECT * FROM diagnostics")
    chuandoanbenhnhan = cursor.fetchall()
    return render_template('chuandoanbenhnhan.html', diagnostics=chuandoanbenhnhan)


@app.route('/danhsachchuandoan')
def danhsachchuandoan():
    cursor = mysql.cursor()
    cursor.execute("SELECT * FROM diagnosticsmaster")
    danhsachchuandoan = cursor.fetchall()
    return render_template('danhsachchuandoan.html', diagnosticsmaster=danhsachchuandoan)

@app.route('/patient')
def patient_main():
    return 'patient_main'
