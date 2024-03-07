
--Задание 4
--1.	Выбрать товары, которые за март 2021 хотя бы на одной аптеке продались в кол-ве, превышающем 15 упаковок
SELECT
	s.sales_date_time,
	prs.product_id
FROM sales s
JOIN product_sales prs USING (sales_id)
WHERE prs.count_of_packages > 15
AND EXTRACT (month from s.sales_date_time) IN (3)
AND EXTRACT (year from s.sales_date_time) IN (2021);

--2.	Среди них выбрать самую высокую цену в марте 2021 и вывести дату, город, аптеку, товар, цену продажи.
SELECT
	s.sales_date_time,
	l.locality_name,
	ph.pharm_name,
	prs.product_price,
	prs.product_id
FROM sales s
JOIN product_sales prs USING (sales_id)
JOIN pharm ph USING (pharm_id)
JOIN locality l ON  l.locality_id = ph.locality_id
WHERE prs.count_of_packages > 15
AND EXTRACT (month from s.sales_date_time) IN (3)
AND EXTRACT (year from s.sales_date_time) IN (2021)
AND prs.product_price = (SELECT MAX(product_price) FROM product_sales);
