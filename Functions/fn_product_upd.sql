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
