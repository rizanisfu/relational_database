-- NO 1: Create database alta_online_shop:
CREATE schema alta_online_shop;

-- ==============================================

-- NO 2a: Create table user:
CREATE TABLE alta_online_shop.user (
    user_id SERIAL PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    alamat TEXT,
    tanggal_lahir DATE,
    status_user VARCHAR(255) NOT NULL,
    gender VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================

-- NO 2b: Create table product:
CREATE TABLE alta_online_shop.product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alta_online_shop.product_type (
    product_type_id SERIAL PRIMARY KEY,
    product_type VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alta_online_shop.product_description (
    product_description_id SERIAL PRIMARY KEY,
    product_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alta_online_shop.payment_method (
    payment_method_id SERIAL PRIMARY KEY,
    payment_method VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================

-- NO 2c: Create table transaction and transaction detail:
CREATE TABLE alta_online_shop.transaction (
    transaction_id SERIAL PRIMARY KEY,
    user_id INT,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES alta_online_shop.user(user_id)
);

CREATE TABLE alta_online_shop.transaction_detail (
    transaction_detail_id SERIAL PRIMARY KEY,
    transaction_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES alta_online_shop.transaction(transaction_id),
    FOREIGN KEY (product_id) REFERENCES alta_online_shop.product(product_id)
);

-- ==============================================

-- NO 3 & 4: Create table kurir:
CREATE TABLE alta_online_shop.kurir (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    ongkos_dasar DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===============================================

-- No 5: Rename tabel kurir menjadi shipping

ALTER TABLE kurir RENAME TO shipping;

--================================================

-- No 6: Hapus/drop tabel shipping karena ternyata tidak dibutuhkan

DROP TABLE IF EXISTS shipping;

-- ===============================================

-- NO 7: Create tables for 1-to-1, 1-to-many, many-to-many relationships:

-- a. 1-to-1: payment_method with description

CREATE TABLE alta_online_shop.description (
    description_id SERIAL PRIMARY KEY,
    payment_method_id INT UNIQUE,
    description_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (payment_method_id) REFERENCES alta_online_shop.payment_method(payment_method_id)
);

-- b. 1-to-many: user with orders
ALTER TABLE alta_online_shop.user
ADD COLUMN orders_id INT;

CREATE TABLE alta_online_shop.orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 0) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES alta_online_shop.user(user_id)
);

-- c. many-to-many: user with payment_method
CREATE TABLE alta_online_shop.user_payment_method_detail (
    user_payment_method_detail SERIAL PRIMARY KEY,
    user_id INT,
    payment_method_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES alta_online_shop.user(user_id),
    FOREIGN KEY (payment_method_id) REFERENCES alta_online_shop.payment_method(payment_method_id)
);
