--Задание 2
--Разработать хранимые процедуры для редактора товаров:
--	Вывод списка товаров с фильтрами по ЖВ (одно значение) и по типу (список значений)
--	Добавление/изменение товара
--	Необходимо добавить проверки входных данных согласно ограничениям из таблицы выше
--	В случае ввода некорректных данных выводить текст с читабельной ошибкой
--	Удаление товара


--Фильтр по товарам
--DROP FUNCTION public.products_filter_get(is_vital boolean,product_type_id integer)
CREATE OR REPLACE FUNCTION public.products_filter_get(
	is_vital boolean,
	product_type_id integer)
    RETURNS TABLE(product_id integer, product_name character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY (
		SELECT pr.product_id, pr.product_name
		FROM products pr
		JOIN product_to_product_type prt
		ON pr.product_id = prt.product_id
		WHERE pr.is_vital= $1 AND prt.product_type_id  =$2
	);
END;
$BODY$;
