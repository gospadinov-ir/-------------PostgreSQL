--Товары
CREATE TABLE IF NOT EXISTS public.products
(
    product_id SERIAL,
    product_name character varying(160) COLLATE pg_catalog."default" NOT NULL,
    is_vital boolean DEFAULT false,
    prescription_id integer,
    CONSTRAINT products_pkey PRIMARY KEY (product_id),
    CONSTRAINT products_product_name_key UNIQUE (product_name),
    CONSTRAINT products_prescription_id_fkey FOREIGN KEY (prescription_id)
        REFERENCES public.product_prescription (prescription_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
