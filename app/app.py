import psycopg
from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_login import LoginManager, UserMixin, login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
import os

app = Flask(__name__)
app.secret_key = 'Yh6Q55iliM21yDzsNrNT3XDBYtU638BixBi8'
#app.config['UPLOAD_FOLDER'] = os.path.join("static", "uploads")
DB_CONFIG='postgresql://postgres:ROlqh90oojMcYjsn@unwisely-utmost-cat.data-1.use1.tembo.io:5432/postgres'

UPLOAD_FOLDER = os.path.join("static", "uploads")
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def get_db_connection():
    return psycopg.connect(DB_CONFIG)

login_manager = LoginManager(app)
login_manager.login_view = 'login'

class User(UserMixin):
    def __init__(self, id, username, password):
        self.id = id
        self.username = username
        self.password = password

@login_manager.user_loader
def load_user(user_id):
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT id, username, password FROM \"user\" WHERE id = %s", (user_id,))
            user = cur.fetchone()
            if user:
                return User(*user)
    return None

@app.route('/basket')
@login_required
def basket():
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                SELECT b.basketid, b.productid, b.quantity, p.productname, p.price, p.photo 
                FROM "basket" b 
                JOIN "product" p ON b.productid = p.productid 
                WHERE b.clientid = (SELECT clientid FROM client WHERE userid = %s)
                """,
                (current_user.id,)
            )
            basket_items = cur.fetchall()
            total_price = sum(item[2] * item[4] for item in basket_items)
            for item in basket_items:
                print(item[5])
            basket_items = [
                dict(
                    basketid=row[0],
                    product=dict(
                        productid=row[1],
                        productname=row[3],
                        price=row[4],
                        photo=row[5]
                    ),
                    quantity=row[2]
                ) for row in basket_items
            ]
    print(basket_items)

    return render_template('basket.html', basket_items=basket_items, total_price=total_price)

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = generate_password_hash(request.form['password'])
        
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT id FROM \"user\" WHERE username = %s", (username,))
                if cur.fetchone():
                    flash('Пользователь уже существует!', 'danger')
                    return redirect(url_for('register'))
                
                # Добавляем нового пользователя в таблицу "user"
                cur.execute("INSERT INTO \"user\"(username, password) VALUES (%s, %s) RETURNING id", (username, password))
                user_id = cur.fetchone()[0]
                
                # Создаем соответствующую запись в таблице "client" с пустыми значениями для обязательных полей
                cur.execute(
                    """
                    INSERT INTO client (userid, name, surname) 
                    VALUES (%s, 'Default Name', 'Default Surname')
                    """,
                    (user_id,)
                )
                
                conn.commit()
                
                login_user(User(user_id, username, password))
                return redirect(url_for('complete_profile'))
    
    return render_template('register.html')

def create_admin():
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            # Проверяем наличие администратора в базе данных
            cur.execute("SELECT id FROM \"user\" WHERE username = 'admin'")
            admin = cur.fetchone()
            
            if not admin:
                # Если администратора нет, создаем его
                hashed_password = generate_password_hash("111")  # Можно изменить пароль
                cur.execute(
                    "INSERT INTO \"user\" (username, password) VALUES (%s, %s)",
                    ("admin", hashed_password)
                )
                conn.commit()
                print("Администратор создан: admin / 111")
            else:
                print("Администратор уже существует.")

# Вызов функции при старте приложения
create_admin()



@app.route('/complete_profile', methods=['GET', 'POST'])
@login_required
def complete_profile():
    if request.method == 'GET':

        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT * FROM client WHERE userid = %s", (current_user.id,))
                client_data = cur.fetchone()
        
        if client_data:
            user_data = {
                'name': client_data[2],
                'surname': client_data[1],
                'patronymic': client_data[3],
                'address': client_data[4],
                'phone': client_data[5],
                'email': client_data[6]
            }
        else:
            user_data = {
                'name': '',
                'surname': '',
                'patronymic': '',
                'address': '',
                'phone': '',
                'email': ''
            }
    


    if request.method == 'POST':
        name = request.form['name']
        surname = request.form['surname']
        patronymic = request.form['patronymic']
        address = request.form['address']
        phone = request.form['phone']
        email = request.form['email']
        
        with get_db_connection() as conn:
            with conn.cursor() as cur:
            #    try:
                    cur.execute(
                        """
                        UPDATE client 
                        SET name = %s, surname = %s, patronymic = %s, address = %s, phone = %s, email = %s 
                        WHERE userid = %s
                        """,
                        (name, surname, patronymic, address, phone, email, current_user.id)
                    )
                    conn.commit()
                    flash('Профиль успешно сохранен!', 'success')
                    return redirect(url_for('products'))
           #     except Exception as e:
            #        conn.rollback()
             #      print(f"Error: {str(e)}")
              #      flash(f'Ошибка при сохранении профиля: {str(e)}', 'danger')
        
    return render_template('profile.html', current_user=user_data)


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']


        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT id, username, password FROM \"user\" WHERE username = %s", (username,))
                user = cur.fetchone()
                
                if user and check_password_hash(user[2], password):
                    login_user(User(user[0], user[1], user[2]))
                    if user[1] == 'admin':
                    
                        return redirect(url_for('admin_dashboard'))
                    
                    else:
                    
                        return redirect(url_for('products'))
                    
                    
                else:
                    flash('Неверные учетные данные', 'danger')
    
    return render_template('login.html')

@app.route('/admin_dashboard')
@login_required
def admin_dashboard():
    if current_user.username != 'admin':
        flash('У вас нет доступа к этой странице.', 'danger')
        return redirect(url_for('home'))
    else:
        return render_template('admin_deshboard.html')

@app.route('/logout')
def logout():
    logout_user()
    flash('Вы вышли из системы.', 'info')
    return redirect(url_for('home'))

@app.route('/products')
def products():
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT productid, productname, description, quantity, price, photo FROM \"product\"")
            products = [dict(
                productid=row[0],
                productname=row[1],
                description=row[2],
                quantity=row[3],
                price=row[4],
                photo=row[5]
            ) for row in cur.fetchall()]
    return render_template('products.html', products=products)


@app.route('/rename_o')
def rename_o():
    
     return render_template('rename_o.html')


@app.route('/add_product', methods=['GET', 'POST'])
@login_required
def add_product():
    if request.method == 'POST':
        productname = request.form['productname']
        description = request.form['description']
        quantity = request.form['quantity']
        price = request.form['price']
        
        if 'photo' not in request.files:
            flash('Ошибка: файл изображения обязателен!', 'danger')
            return redirect(url_for('add_product'))
        
        photo = request.files['photo']
        if photo.filename == '':
            flash('Ошибка: выберите файл изображения!', 'danger')
            return redirect(url_for('add_product'))
        
        filename = secure_filename(photo.filename)
        photo_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        photo.save(photo_path)
        
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("INSERT INTO product (productname, description, quantity, price, photo) VALUES (%s, %s, %s, %s, %s)",
                            (productname, description, quantity, price, photo_path))
                conn.commit()
                flash('Товар успешно добавлен!', 'success')
                print(filename)
                print(photo_path)
                print(photo)
                return redirect(url_for('products'))
    
    return render_template('add_product.html')

@app.route('/product/<int:product_id>')
def product_detail(product_id):
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT productid, productname, description, quantity, price, photo FROM \"product\" WHERE productid = %s", (product_id,))
            product = cur.fetchone()
            if not product:
                flash('Товар не найден!', 'danger')
                return redirect(url_for('products'))
            product_data = dict(
                productid=product[0],
                productname=product[1],
                description=product[2],
                quantity=product[3],
                price=product[4],
                photo=product[5].replace("static/", "").replace("\\", "/")
            )
    #print(product)
    #print(product['photo'])
    return render_template('product_detail.html', product=product_data)


@app.route('/add_to_basket/<int:product_id>', methods=['POST'])
@login_required
def add_to_basket(product_id):
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            try:
                # Получаем clientid текущего пользователя
                cur.execute("SELECT clientid FROM client WHERE userid = %s", (current_user.id,))
                clientid_result = cur.fetchone()
                
                if not clientid_result:
                    # Если клиент не найден, создаем нового клиента
                    cur.execute("INSERT INTO client (userid) VALUES (%s) RETURNING clientid", (current_user.id,))
                    clientid_result = cur.fetchone()
                    
                    if not clientid_result:
                        flash('Ошибка: Не удалось создать клиента!', 'danger')
                        return redirect(url_for('products'))
                
                clientid = clientid_result[0]
                
                # Проверяем наличие товара в корзине
                cur.execute("SELECT quantity FROM basket WHERE clientid = %s AND productid = %s", (clientid, product_id))
                basket_item = cur.fetchone()
                
                if basket_item:
                    # Если товар уже есть в корзине, увеличиваем количество
                    cur.execute(
                        "UPDATE basket SET quantity = quantity + 1 WHERE clientid = %s AND productid = %s",
                        (clientid, product_id)
                    )
                else:
                    # Если товара нет в корзине, добавляем его
                    cur.execute(
                        "INSERT INTO basket (clientid, productid, quantity) VALUES (%s, %s, 1)",
                        (clientid, product_id)
                    )
                
                conn.commit()
                flash('Товар добавлен в корзину!', 'success')
            except Exception as e:
                conn.rollback()
                print(f"Error: {str(e)}")
                flash(f'Ошибка при добавлении товара в корзину: {str(e)}', 'danger')
    return redirect(url_for('basket'))


@app.route('/update_basket/<int:product_id>', methods=['POST'])
@login_required
def update_basket(product_id):
    quantity = int(request.form['quantity'])
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            try:
                cur.execute(
                    "UPDATE basket SET quantity = %s WHERE clientid = (SELECT clientid FROM client WHERE userid = %s) AND productid = %s",
                    (quantity, current_user.id, product_id)
                )
                conn.commit()
                flash('Количество товара успешно обновлено!', 'success')
            except Exception as e:
                conn.rollback()
                print(f"Error: {str(e)}")
                flash(f'Ошибка при обновлении количества товара: {str(e)}', 'danger')
    return redirect(url_for('basket'))

@app.route('/remove_from_basket/<int:product_id>', methods=['POST'])
@login_required
def remove_from_basket(product_id):
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            try:
                cur.execute(
                    "DELETE FROM basket WHERE clientid = (SELECT clientid FROM client WHERE userid = %s) AND productid = %s",
                    (current_user.id, product_id)
                )
                conn.commit()
                flash('Товар успешно удален из корзины!', 'success')
            except Exception as e:
                conn.rollback()
                print(f"Error: {str(e)}")
                flash(f'Ошибка при удалении товара из корзины: {str(e)}', 'danger')
    return redirect(url_for('basket'))


@app.route('/place_order', methods=['POST'])
@login_required
def place_order():
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            try:
                # Получаем clientid текущего пользователя
                cur.execute("SELECT clientid FROM client WHERE userid = %s", (current_user.id,))
                clientid_result = cur.fetchone()
                
                if not clientid_result:
                    flash('Ошибка: Не удалось найти клиента!', 'danger')
                    return redirect(url_for('basket'))
                
                clientid = clientid_result[0]
                
                # Получаем данные пользователя из таблицы "client"
                cur.execute(
                    """
                    SELECT address, phone, email 
                    FROM client 
                    WHERE clientid = %s
                    """,
                    (clientid,)
                )
                user_data = cur.fetchone()
                
                if not user_data:
                    flash('Ошибка: Не удалось получить данные пользователя!', 'danger')
                    return redirect(url_for('basket'))
                
                address, phone, email = user_data
                
                # Вычисляем общую стоимость товаров в корзине
                cur.execute(
                    """
                    SELECT SUM(p.price * b.quantity) 
                    FROM basket b 
                    JOIN product p ON b.productid = p.productid 
                    WHERE b.clientid = %s
                    """,
                    (clientid,)
                )
                total_cost = cur.fetchone()[0] or 0
                
                # Вставляем запись в таблицу "order"
                cur.execute(
                    """
                    INSERT INTO "order" (clientid, status, address, phone, email, cost) 
                    VALUES (%s, 'В обработке', %s, %s, %s, %s) 
                    RETURNING orderid
                    """,
                    (clientid, address, phone, email, total_cost)
                )
                orderid = cur.fetchone()[0]
                
                # Копируем товары из корзины в таблицу "productorder"
                cur.execute(
                    """
                    INSERT INTO productorder (orderid, productid, quantity) 
                    SELECT %s, productid, quantity FROM basket WHERE clientid = %s
                    """,
                    (orderid, clientid)
                )
                
                # Очищаем корзину после оформления заказа
                cur.execute("DELETE FROM basket WHERE clientid = %s", (clientid,))
                
                conn.commit()
                flash('Заказ успешно оформлен!', 'success')
            except Exception as e:
                conn.rollback()
                print(f"Error: {str(e)}")
                flash(f'Ошибка при оформлении заказа: {str(e)}', 'danger')
    return redirect(url_for('basket'))

@app.route('/orders')
@login_required
def orders():
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            # Получаем все заказы текущего пользователя
            cur.execute(
                """
                SELECT o.orderid, o.status, o.cost, o.address, o.phone, o.email 
                FROM "order" o 
                JOIN client c ON o.clientid = c.clientid 
                WHERE c.userid = %s
                """,
                (current_user.id,)
            )
            orders = cur.fetchall()
            orders_list = [
                dict(
                    orderid=row[0],
                    status=row[1],
                    cost=row[2],
                    address=row[3],
                    phone=row[4],
                    email=row[5]
                ) for row in orders
            ]
    return render_template('orders.html', orders=orders_list)

@app.route('/order/<int:order_id>')
@login_required
def order_detail(order_id):
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            # Получаем информацию о заказе
            cur.execute(
                """
                SELECT o.orderid, o.status, o.cost, o.address, o.phone, o.email 
                FROM "order" o 
                WHERE o.orderid = %s AND o.clientid = (SELECT clientid FROM client WHERE userid = %s)
                """,
                (order_id, current_user.id)
            )
            order = cur.fetchone()
            
            if not order:
                flash('Заказ не найден!', 'danger')
                return redirect(url_for('orders'))
            
            order_info = dict(
                orderid=order[0],
                status=order[1],
                cost=order[2],
                address=order[3],
                phone=order[4],
                email=order[5]
            )
            
            # Получаем товары в заказе
            cur.execute(
                """
                SELECT p.productname, po.quantity, p.price 
                FROM productorder po 
                JOIN product p ON po.productid = p.productid 
                WHERE po.orderid = %s
                """,
                (order_id,)
            )
            order_items = cur.fetchall()
            order_items_list = [
                dict(
                    productname=row[0],
                    quantity=row[1],
                    price=row[2]
                ) for row in order_items
            ]
    
    return render_template('order_detail.html', order=order_info, order_items=order_items_list)

@app.route('/')
def home():
    return render_template('home.html')

@app.context_processor
def inject_basket_count():
    if current_user.is_authenticated:
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT SUM(quantity) FROM \"basket\" WHERE clientid = (SELECT clientid FROM client WHERE userid = %s)", (current_user.id,))
                count = cur.fetchone()[0]
                return dict(basket_count=count or 0)
    return dict(basket_count=0)

if __name__ == '__main__':
    app.run(debug=True)