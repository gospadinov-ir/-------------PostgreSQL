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
