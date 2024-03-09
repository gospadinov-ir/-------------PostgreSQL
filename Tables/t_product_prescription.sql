--Рецептурность товара
CREATE TABLE IF NOT EXISTS public.product_prescription
(
    prescription_id integer NOT NULL,
    prescription_name character varying(80) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT product_presctription_pkey PRIMARY KEY (prescription_id)
);
