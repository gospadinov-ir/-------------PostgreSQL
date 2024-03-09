--Товар - Продажи
CREATE TABLE IF NOT EXISTS public.product_sales
(
    id integer NOT NULL DEFAULT nextval('product_sales_id_seq'::regclass),
    product_id bigint NOT NULL,
    product_price numeric NOT NULL,
    count_of_packages integer NOT NULL,
    sales_id bigint NOT NULL,
    CONSTRAINT product_sales_pkey PRIMARY KEY (id),
    CONSTRAINT product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.products (product_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT sales_id_fkey FOREIGN KEY (sales_id)
        REFERENCES public.sales (sales_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);
