--Прайс товаров
CREATE TABLE product_price (
	price_id SMALLINT PRIMARY KEY,
	price NUMERIC (9,2) NOT NULL,
	discounted_price NUMERIC (9,2),
	product_id INTEGER UNIQUE REFERENCES products(product_id)
	ON UPDATE CASCADE
    ON DELETE CASCADE
);
