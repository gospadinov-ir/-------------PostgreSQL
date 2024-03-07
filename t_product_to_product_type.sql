--МНожественная связь товаров и типов
CREATE TABLE IF NOT EXISTS public.product_to_product_type
(
    id integer NOT NULL,
    product_id bigint NOT NULL,
    product_type_id integer NOT NULL,
    CONSTRAINT product_to_product_type_pkey PRIMARY KEY (id),
    CONSTRAINT product_to_product_type_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.products (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_to_product_type_product_type_id_fkey FOREIGN KEY (product_type_id)
        REFERENCES public.product_type (product_type_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
