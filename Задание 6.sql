--Задание 6
--При помощи SQL-запроса сформировать JSON следующего вида:
--“Номер чека” : [ “Месяц” , “Аптека”, “Сумма уп” ],

SELECT json_build_object(sales.check_num, json_build_array(to_char(sales.sales_date_time, 'MM'), pharm.pharm_name, product_sales.count_of_packages))
FROM sales 
INNER JOIN pharm USING (pharm_id)
INNER JOIN product_sales USING (sales_id)

