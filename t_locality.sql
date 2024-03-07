--Нас. пункт
CREATE TABLE IF NOT EXISTS public.locality
(
    locality_id integer NOT NULL,
    locality_name character varying(160) COLLATE pg_catalog."default" NOT NULL,
    region_id integer,
    CONSTRAINT locality_pkey PRIMARY KEY (locality_id),
    CONSTRAINT region_id FOREIGN KEY (region_id)
        REFERENCES public.region (region_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);
