--Продажи
CREATE TABLE IF NOT EXISTS public.sales
(
    sales_id integer NOT NULL DEFAULT nextval('sales_sales_id_seq'::regclass),
    sales_date_time timestamp with time zone DEFAULT now(),
    check_num bigint NOT NULL,
    pharm_id bigint,
    CONSTRAINT sales_pkey PRIMARY KEY (sales_id),
    CONSTRAINT sales_pharm_id_fkey FOREIGN KEY (pharm_id)
        REFERENCES public.pharm (pharm_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
