--Формат аптеки
CREATE TABLE IF NOT EXISTS public.pharm_format
(
    format_id integer NOT NULL,
    format_name character varying(30) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pharm_format_pkey PRIMARY KEY (format_id)
);
