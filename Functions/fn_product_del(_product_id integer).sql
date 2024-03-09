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
