--Тип товара
CREATE TABLE IF NOT EXISTS public.product_type
(
    product_type_id integer NOT NULL,
    product_type_name character varying(80) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT product_type_pkey PRIMARY KEY (product_type_id)
);
