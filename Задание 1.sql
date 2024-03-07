--Задание 1
--По таблице ниже при помощи SQL-запросов:
--1)	Разработать структуру таблиц
--2)	Выбрать правильные типы данных для столбцов и добавить указанные ограничения
--3)	При необходимости добавить недостающие столбцы и таблицы
--4)	Добавить первичные ключи, индексы и связи между таблицами

--Тип товара
CREATE TABLE IF NOT EXISTS public.product_type
(
    product_type_id integer NOT NULL,
    product_type_name character varying(80) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT product_type_pkey PRIMARY KEY (product_type_id)
);

--Рецептурность товара
CREATE TABLE IF NOT EXISTS public.product_prescription
(
    prescription_id integer NOT NULL,
    prescription_name character varying(80) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT product_presctription_pkey PRIMARY KEY (prescription_id)
);

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

--Регион
CREATE TABLE IF NOT EXISTS public.region
(
    region_id integer NOT NULL,
    region_name character varying(40) COLLATE pg_catalog."default",
    CONSTRAINT region_pkey PRIMARY KEY (region_id)
);

--Нас. пункт
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

--Формат аптеки
CREATE TABLE IF NOT EXISTS public.pharm_format
(
    format_id integer NOT NULL,
    format_name character varying(30) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pharm_format_pkey PRIMARY KEY (format_id)
);

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

--наполнение таблиц
INSERT INTO product_type VALUES (1,	"Лекарственные препараты"), (2,	"Лекарственное растительное сырье в заводской упаковке");
INSERT INTO product_prescription VALUES(1,	"Рецептурный"),(2,	"Не рецептурный");
INSERT INTO products VALUES(2,	"Парацатемол",	false,	1), (1,	"Корвалол",	false,	2);
INSERT INTO product_to_product_type VALUES(1,1,1), (2,1,2), (3,2,2);
INSERT INTO locality VALUES (1, 'Краснодар'), (2, 'Пос. Плодородный'),(3,'Сочи'),(4,'Ставрополь'),(5,'Севастополь');
INSERT INTO pharm_format VALUES (1, 'Сезонная'), (2, 'Круглосуточная');
INSERT INTO pharm VALUES (1, 'Апрель',1,2,1), (2, 'Аптечный склад',2,1,1), (3,"Апрель. ул. Ленина, 93",3,3,1),(4,"Апрель. ул. Виноградная, 2",4,3,2), (5,"Аптечный склад. ул. Селезнева, 6",5,3,3);
INSERT INTO sales VALUES (1,'2024-02-17 15:05:06 +3:00',	1,	1,	1,	6,	100.50); (6,DEFAULT,	6,	4);
INSERT INTO product_sales VALUES (8, 8, 2100, 3, 6);


--Селекты
select * from products join product_to_product_type USING (product_id);
select * from product_type
select * from product_to_product_type
select * from product_type
select * from pharm_format
select * from pharm join locality USING (locality_id)
select * from locality
select * from region
select * from product_prescription;
select * from product_to_product_type;
select * from product_sales join product_ on products.product_id=
select * from sales join product_sales USING (sales_id);
