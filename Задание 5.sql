SELECT 
	prs.product_id,
	s.sales_date_time
FROM sales s
JOIN product_sales prs USING (sales_id)
WHERE EXTRACT (month from s.sales_date_time) IN (3,4)
AND EXTRACT (year from s.sales_date_time) IN (2021)
GROUP BY prs.product_id,
AND EXTRACT (month from s.sales_date_time);