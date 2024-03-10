--Задание 5
--Рассчитать выручку за апрель и май 2021 в разрезе товара и вывести разницу выручки мая относительно апреля.
--Апрель 2021	Май 2021	Сравнение
SELECT
	prs.product_id,
	SUM(prs.product_price)
		FILTER (WHERE EXTRACT (month from s.sales_date_time) IN (3)) AS "Май 2021",
	SUM(prs.product_price)
		FILTER (WHERE EXTRACT (month from s.sales_date_time) IN (4)) AS "Апрель 2021"
FROM sales s
JOIN product_sales prs USING (sales_id)
JOIN pharm ph USING (pharm_id)
JOIN locality l ON  l.locality_id = ph.locality_id
WHERE prs.count_of_packages > 15
GROUP BY prs.product_id;

--наполнение таблиц
INSERT INTO product_type VALUES (1,	"Лекарственные препараты"), (2,	"Лекарственное растительное сырье в заводской упаковке");
INSERT INTO product_prescription VALUES(1,	"Рецептурный"),(2,	"Не рецептурный");
INSERT INTO products VALUES(2,	"Парацатемол",	false,	1), (1,	"Корвалол",	false,	2);
INSERT INTO product_to_product_type VALUES(1,1,1), (2,1,2), (3,2,2);
INSERT INTO locality VALUES (1, 'Краснодар'), (2, 'Пос. Плодородный'),(3,'Сочи'),(4,'Ставрополь'),(5,'Севастополь');
INSERT INTO pharm_format VALUES (1, 'Сезонная'), (2, 'Круглосуточная');
INSERT INTO pharm VALUES (1, 'Апрель',1,2,1), (2, 'Аптечный склад',2,1,1), (3,"Апрель. ул. Ленина, 93",3,3,1),(4,"Апрель. ул. Виноградная, 2",4,3,2), (5,"Аптечный склад. ул. Селезнева, 6",5,3,3);
INSERT INTO sales VALUES (1,'2024-02-17 15:05:06 +3:00',	1,	1,	1,	6,	100.50); (6,DEFAULT,	6,	4);
INSERT INTO product_sales VALUES (8, 8, 2100, 3, 6);


--Селекты
select * from products join product_to_product_type USING (product_id);
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

--работа с JSON
SELECT json_build_object ('name','Иван', 'surname', 'Петров', 'age', 30);
SELECT '{"name" : "Иван", "surname" : "Петров", "age" : 30}'::jsonb -> 'age' as age;
SELECT json_agg(json_build_object('name', client_name, 'age', age)) AS clients
from clients;

update clients c
set json_data = (select to_jsonb(e.*)
				from (select i.client_id, i.client_name, i.age
					 from clients i
					 where i.client_id = c.client_id) e);

INSERT INTO clients VALUES
	(DEFAULT,
	'Семенов Семен',
	21,
	'{"client_id": 2,"name" : "Семенов Семен","age" : 30,"phone": 9003004050}'
	);

ALTER TABLE clients ADD COLUMN phone integer;

UPDATE clients
SET phone = (select json_data::integer ->> 3)
	WHERE client_id =2;
