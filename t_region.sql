--Регион
CREATE TABLE IF NOT EXISTS public.region
(
    region_id integer NOT NULL,
    region_name character varying(40) COLLATE pg_catalog."default",
    CONSTRAINT region_pkey PRIMARY KEY (region_id)
);
