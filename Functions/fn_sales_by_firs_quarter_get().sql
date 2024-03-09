

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
