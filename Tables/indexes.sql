--1.2. Индексы
CREATE INDEX IF NOT EXISTS pharm_id_index
    ON public.pharm USING btree
    (pharm_id ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS pharm_name_index
    ON public.pharm USING btree
    (pharm_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS product_id_index
    ON public.products USING btree
    (product_id ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS product_name_index
    ON public.products USING btree
    (product_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS check_num_index
    ON public.sales USING btree
    (check_num ASC NULLS LAST)
    TABLESPACE pg_default;
