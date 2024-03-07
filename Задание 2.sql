--Задание 2
--Разработать хранимые процедуры для редактора товаров:
--	Вывод списка товаров с фильтрами по ЖВ (одно значение) и по типу (список значений)
--	Добавление/изменение товара
--	Необходимо добавить проверки входных данных согласно ограничениям из таблицы выше
--	В случае ввода некорректных данных выводить текст с читабельной ошибкой
--	Удаление товара


--Фильтр по товарам
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

--Добавление товаров
CREATE OR REPLACE FUNCTION public.product_ins(
	_product_id integer,
	_product_name character varying,
	_is_vital boolean,
	_prescription_id integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
	INSERT INTO products(product_id, product_name, is_vital, prescription_id)
	VALUES($1,$2,$3,$4);
EXCEPTION
	WHEN SQLSTATE '23505' THEN
		RAISE EXCEPTION 'Товар с таким ИД или наименованием уже существует: %', _product_name;
	WHEN SQLSTATE '22001' THEN
		RAISE EXCEPTION 'Наименование товара не должно содержать больше 160 символов';
END;
$BODY$;

--Изменение товаров
CREATE OR REPLACE FUNCTION public.product_upd(
	_product_id integer,
	_product_name character varying,
	_is_vital boolean,
	_prescription_id integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
	UPDATE products SET (product_id, product_name, is_vital, prescription_id) = ($1,$2,$3,$4)
		WHERE product_id =$1;
EXCEPTION
	WHEN SQLSTATE '22001' THEN
		RAISE EXCEPTION 'Наименование товара не должно содержать больше 160 символов';
END;
$BODY$;

--Удаление товаров
CREATE OR REPLACE FUNCTION public.product_del(
	_product_id integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
	DELETE from products
		WHERE product_id = $1;
END;
$BODY$;
