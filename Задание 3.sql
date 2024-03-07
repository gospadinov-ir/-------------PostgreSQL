select * from products join product_to_product_type on products.product_id= product_to_product_type.product_id;
select * from product_type
select * from product_to_product_type
select * from product_type
select * from pharm_format
select * from pharm join locality USING (locality_id)
select * from locality
select * from region
select * from product_prescription;
select * from product_to_product_type;
select * from product_sales join product_ on products.product_id=
select * from sales join product_sales USING (sales_id);



INSERT INTO product_sales VALUES
	(8, 8, 2100, 3, 6);
	

INSERT INTO locality VALUES(3,'Сочи'),(4,'Ставрополь'),(5,'Севастополь');

INSERT INTO sales VALUES
	(6,DEFAULT,	6,	4);
	

ALTER TABLE product_sales ADD COLUMN product_type_id INTEGER REFERENCES products(product_type_id);
INSERT INTO pharm VALUES(
	2,
	'Аптечный склад',
	2,
	1
); 

-- Задание 3. Написать SQL-запрос: 
--1.	Фильтры:
--a.	Дата продажи – 1е кварталы 2020 и 2021

CREATE OR REPLACE FUNCTION sales_by_firs_quarter_get ()
	RETURNS TABLE (_sales_id INTEGER, _sales_date_time TIMESTAMP with time zone)
AS $$
BEGIN
	RETURN QUERY (
		SELECT sales_id, sales_date_time FROM sales
		WHERE 
		EXTRACT (month from sales.sales_date_time) IN (1,2,3)
		AND EXTRACT (year from sales.sales_date_time) IN (2020,2021)
	);
END;
$$ 	LANGUAGE plpgsql

SELECT * FROM sales_by_first_quarter_get()

--b.	Аптека - города Краснодар, Сочи, Ставрополь и Севастополь, формат - «Клуб»
CREATE OR REPLACE FUNCTION pharm_filter_get(_locality_id INTEGER, _format_id INTEGER)
	RETURNS TABLE (pharm_id INTEGER, pharm_name VARCHAR, locality_name VARCHAR, format_name VARCHAR)
AS $$
BEGIN
	RETURN QUERY (
		SELECT ph.pharm_id, ph.pharm_name, l.locality_name, pf.format_name
		from pharm ph
		JOIN locality l USING (locality_id)
		JOIN pharm_format pf USING (format_id)
		WHERE locality_id IN ($1)
		AND format_id = $2
	);
END;
$$ LANGUAGE plpgsql

SELECT * FROM pharm_filter_get(4, 3)
--2.	В разрезе регионов и типов товаров вывести:
--a.	среднюю цену по всем попавшим в фильтр чекам

SELECT AVG(prs.product_price), ph.region_id, prt.product_type_id
FROM sales s
JOIN product_sales prs USING (sales_id)
JOIN pharm ph USING (pharm_id)
JOIN product_to_product_type prt ON prs.product_id = prt.product_id
GROUP BY ph.region_id, prt.product_type_id;

--b.	кол-во уникальных аптек, где цена продажи товара была больше 300р.
SELECT DISTINCT ON (s.pharm_id) COUNT (s.pharm_id) AS count_distinct_pharm, ph.region_id, prt.product_type_id
FROM sales s
JOIN product_sales prs USING (sales_id)
JOIN pharm ph USING (pharm_id)
JOIN product_to_product_type prt ON prs.product_id =3.	Пронумеровать типы в разрезе региона по убыванию средней цены
WHERE prs.product_price > 300
GROUP BY s.pharm_id, ph.region_id, prt.product_type_id;

--c.	список уникальных населенных пунктов через точку с запятой
SELECT DISTINCT ON (l.locality_id) l.locality_id, l.locality_name, ph.region_id, prt.product_type_id
FROM sales s
JOIN product_sales prs USING (sales_id)
JOIN pharm ph USING (pharm_id)
JOIN locality l ON ph.locality_id=l.locality_id 
JOIN product_to_product_type prt ON prs.product_id = prt.product_id
GROUP BY l.locality_id, ph.region_id, prt.product_type_id;

--3.	Пронумеровать типы в разрезе региона по убыванию средней цены
SELECT 
	ROW_NUMBER () OVER (ORDER BY AVG(prs.product_price) DESC) AS rn,
	AVG(prs.product_price), 
	ph.region_id, 
	prt.product_type_id
FROM sales s
JOIN product_sales prs USING (sales_id)
JOIN pharm ph USING (pharm_id)
JOIN product_to_product_type prt ON prs.product_id = prt.product_id
GROUP BY ph.region_id, prt.product_type_id;

--4.	Оставить те записи, где порядковый номер делится на 3
SELECT *
FROM (
	SELECT
		AVG(prs.product_price) as avg_price, 
		ph.region_id as region_id, 
		prt.product_type_id as product_type_id,
		ROW_NUMBER () OVER (ORDER BY AVG(prs.product_price) DESC) AS row_num
	FROM sales s
	JOIN product_sales prs USING (sales_id)
	JOIN pharm ph USING (pharm_id)
	JOIN product_to_product_type prt ON prs.product_id = prt.product_id
	GROUP BY ph.region_id, prt.product_type_id
	) sub
WHERE row_num / 3=1; 
