--Аптеки
CREATE TABLE IF NOT EXISTS public.pharm
(
    pharm_id integer NOT NULL DEFAULT nextval('pharm_pharm_id_seq'::regclass),
    pharm_name character varying(160) COLLATE pg_catalog."default" NOT NULL,
    locality_id integer NOT NULL,
    format_id integer NOT NULL,
    region_id integer,
    CONSTRAINT pharm_pkey PRIMARY KEY (pharm_id),
    CONSTRAINT pharm_format_id_fkey FOREIGN KEY (format_id)
        REFERENCES public.pharm_format (format_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT pharm_locality_id_fkey FOREIGN KEY (locality_id)
        REFERENCES public.locality (locality_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT pharm_region_id_fkey FOREIGN KEY (region_id)
        REFERENCES public.region (region_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);
