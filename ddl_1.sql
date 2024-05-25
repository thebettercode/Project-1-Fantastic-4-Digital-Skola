
--Tugas melengkapi script ddl_1.sql berdasarkan ERD
        CREATE TABLE IF NOT EXISTS dim_users (
            user_id INT NOT NULL PRIMARY KEY,
            user_first_name VARCHAR(255) NOT NULL,
            user_last_name VARCHAR(255) NOT NULL,
            user_gender VARCHAR(50) NOT NULL,
            user_address VARCHAR(255),
            user_birthday DATE NOT NULL,
            user_join DATE NOT NULL
        );
        CREATE TABLE IF NOT EXISTS dim_payments (
            payment_id INT NOT NULL PRIMARY KEY,
            payment_name VARCHAR(255) NOT NULL,
            payment_status BOOLEAN NOT NULL
        );
        CREATE TABLE IF NOT EXISTS dim_shippers (
            shipper_id INT NOT NULL PRIMARY KEY,
            shipper_name VARCHAR(255) NOT NULL
        );
        CREATE TABLE IF NOT EXISTS dim_ratings (
            rating_id INT NOT NULL PRIMARY KEY,
            rating_level INT NOT NULL,
            rating_status VARCHAR(255) NOT NULL
        );
        CREATE TABLE IF NOT EXISTS dim_voucher (
            voucher_id INT NOT NULL PRIMARY KEY,
            voucher_name VARCHAR(255) NOT NULL,
            voucher_price INT,
            voucher_created DATE NOT NULL,
            user_id INT NOT NULL,
            FOREIGN KEY (user_id) REFERENCES dim_users(user_id)
        );
--		Tugas melengkapi dim_products & dim_product_category
		CREATE TABLE IF NOT EXISTS dim_products(
			product_id INT NOT NULL PRIMARY KEY,
			product_category_id INT NOT NULL,
			product_name VARCHAR(255) NOT NULL,
			product_created DATE NOT NULL,
			product_price INT NOT NULL,
			product_discount INT,
			FOREIGN KEY (product_category_id) REFERENCES dim_product_category(product_category_id)
		);
		CREATE TABLE IF NOT EXISTS dim_product_category(
			product_category_id INT NOT NULL PRIMARY KEY,
			product_category_name VARCHAR(255) NOT NULL			
		);
       
       
        CREATE TABLE IF NOT EXISTS fact_orders (
            order_id INT NOT NULL PRIMARY KEY,
            order_date DATE NOT NULL,
            user_id INT NOT NULL,
            payment_id INT NOT NULL,
            shipper_id INT NOT NULL,
            order_price INT NOT NULL,
            order_discount INT,
            voucher_id INT,
            order_total INT NOT NULL,
            rating_id INT NOT NULL,
            FOREIGN KEY (user_id) REFERENCES dim_users(user_id),
            FOREIGN KEY (payment_id) REFERENCES dim_payments(payment_id),
            FOREIGN KEY (shipper_id) REFERENCES dim_shippers(shipper_id),
            FOREIGN KEY (voucher_id) REFERENCES dim_voucher(voucher_id),
            FOREIGN KEY (rating_id) REFERENCES dim_ratings(rating_id)
        );
--		Tugas melengkapi fact_order_items
       	CREATE TABLE IF NOT EXISTS fact_order_items (
       		order_item_id INT NOT NULL PRIMARY KEY,
       		order_id INT NOT NULL,
       		product_id INT NOT NULL,
       		order_item_quantity INT,
       		product_discount INT,
       		product_subdiscount INT,
       		product_price INT NOT NULL,
       		product_subprice INT NOT NULL,
       		FOREIGN KEY (order_id) REFERENCES fact_orders(order_id),
       		FOREIGN KEY (product_id) REFERENCES dim_products(product_id)      
       );
       
