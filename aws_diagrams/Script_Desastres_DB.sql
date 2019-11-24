-- Database: desastres

-- DROP DATABASE desastres;

CREATE DATABASE desastres
    WITH 
    OWNER = group03user
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

GRANT ALL ON DATABASE desastres TO group03user;

GRANT TEMPORARY, CONNECT ON DATABASE desastres TO PUBLIC;



-- Tables:
-- Table: public.divipola

-- DROP TABLE public.divipola;

CREATE TABLE public.divipola
(
    divipola_id text COLLATE pg_catalog."default" NOT NULL,
    cod_departamento text COLLATE pg_catalog."default" NOT NULL,
    departamento text COLLATE pg_catalog."default" NOT NULL,
    cod_municipio text COLLATE pg_catalog."default",
    municipio text COLLATE pg_catalog."default",
    CONSTRAINT divipola_pkey PRIMARY KEY (divipola_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.divipola
    OWNER to group03user;
	
-- Table: public.estimacion_poblaciones

-- DROP TABLE public.estimacion_poblaciones;

CREATE TABLE public.estimacion_poblaciones
(
    id integer NOT NULL DEFAULT nextval('estimacion_poblaciones_id_seq'::regclass),
    divipola_id text COLLATE pg_catalog."default" NOT NULL,
    grupos_de_edad text COLLATE pg_catalog."default",
    poblacion bigint,
    periodo text COLLATE pg_catalog."default",
    genero text COLLATE pg_catalog."default",
    CONSTRAINT estimacion_poblaciones_pkey PRIMARY KEY (id),
    CONSTRAINT estpob_divipola__id_fk FOREIGN KEY (divipola_id)
        REFERENCES public.divipola (divipola_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.estimacion_poblaciones
    OWNER to group03user;

-- Index: fki_estpob_divipola__id_fk

-- DROP INDEX public.fki_estpob_divipola__id_fk;

CREATE INDEX fki_estpob_divipola__id_fk
    ON public.estimacion_poblaciones USING btree
    (divipola_id COLLATE pg_catalog."default")
    TABLESPACE pg_default;

-- Table: public.eventos

-- DROP TABLE public.eventos;

CREATE TABLE public.eventos
(
    id integer NOT NULL DEFAULT nextval('eventos_id_seq'::regclass),
    nombre_evento text COLLATE pg_catalog."default" NOT NULL,
    categoria text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT eventos_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.eventos
    OWNER to group03user;

-- Table: public.historico_desastres

-- DROP TABLE public.historico_desastres;

CREATE TABLE public.historico_desastres
(
    id integer NOT NULL DEFAULT nextval('historico_desastres_id_seq'::regclass),
    divipola_id text COLLATE pg_catalog."default" NOT NULL,
    evento_id integer NOT NULL,
    muertos double precision,
    heridos double precision,
    desaparecidos double precision,
    personas double precision,
    familias double precision,
    viviendas_destruidas double precision,
    viviendas_averiadas double precision,
    vias double precision,
    ptes_vehiculo double precision,
    pte_peatonal double precision,
    acueductos double precision,
    alcantarillados double precision,
    centro_salud double precision,
    centro_educativo double precision,
    centro_comunitario double precision,
    hectareas double precision,
    otros double precision,
    subsidio_arriendo double precision,
    menajes double precision,
    ap_aliment double precision,
    materiales_const double precision,
    sacos double precision,
    otros1 double precision,
    trans_economicas double precision,
    recursos_ejecutados double precision,
    fecha date,
    CONSTRAINT historico_desastres_pkey PRIMARY KEY (id),
    CONSTRAINT histdes_divipola_id_fk FOREIGN KEY (divipola_id)
        REFERENCES public.divipola (divipola_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT histdes_evento_id_fk FOREIGN KEY (evento_id)
        REFERENCES public.eventos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.historico_desastres
    OWNER to group03user;

-- Index: fki_histdes_divipola_id_fk

-- DROP INDEX public.fki_histdes_divipola_id_fk;

CREATE INDEX fki_histdes_divipola_id_fk
    ON public.historico_desastres USING btree
    (divipola_id COLLATE pg_catalog."default")
    TABLESPACE pg_default;

-- Index: fki_histdes_evento_id_fk

-- DROP INDEX public.fki_histdes_evento_id_fk;

CREATE INDEX fki_histdes_evento_id_fk
    ON public.historico_desastres USING btree
    (evento_id)
    TABLESPACE pg_default;

-- Table: public.load_disasters

-- DROP TABLE public.load_disasters;

CREATE TABLE public.load_disasters
(
    fecha timestamp without time zone,
    departamento text COLLATE pg_catalog."default",
    municipio text COLLATE pg_catalog."default",
    evento text COLLATE pg_catalog."default",
    codificacionsegundivipola double precision,
    muertos double precision,
    heridos double precision,
    desapa double precision,
    personas double precision,
    familias double precision,
    viviendasdestru double precision,
    viviendasaver double precision,
    vias double precision,
    ptesvehic double precision,
    ptepeat double precision,
    acued double precision,
    alcant double precision,
    csalud double precision,
    ceducat double precision,
    ccomunit double precision,
    hectareas double precision,
    otros double precision,
    subsidiodearriendo double precision,
    menajes double precision,
    apaliment double precision,
    materialesconst double precision,
    sacos double precision,
    otros1 double precision,
    transeconomicas double precision,
    recejecutados double precision
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.load_disasters
    OWNER to group03user;

-- Table: public.load_divipola

-- DROP TABLE public.load_divipola;

CREATE TABLE public.load_divipola
(
    cod_depto text COLLATE pg_catalog."default",
    cod_mun text COLLATE pg_catalog."default",
    depto text COLLATE pg_catalog."default",
    mun text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.load_divipola
    OWNER to group03user;

-- Table: public.load_populations

-- DROP TABLE public.load_populations;

CREATE TABLE public.load_populations
(
    codigo text COLLATE pg_catalog."default",
    departamento text COLLATE pg_catalog."default",
    grupos_de_edad text COLLATE pg_catalog."default",
    poblacion bigint,
    periodo text COLLATE pg_catalog."default",
    genero text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.load_populations
    OWNER to group03user;

-- Views
-- View: public.vw_desastres

-- DROP VIEW public.vw_desastres;

CREATE OR REPLACE VIEW public.vw_desastres
 AS
 SELECT a.fecha,
    b.departamento,
    b.municipio,
    e.nombre_evento AS evento,
    e.categoria,
    a.muertos,
    a.heridos,
    a.desaparecidos,
    a.personas,
    a.familias,
    a.viviendas_destruidas,
    a.viviendas_averiadas,
    a.vias,
    a.ptes_vehiculo,
    a.pte_peatonal,
    a.acueductos,
    a.alcantarillados,
    a.centro_salud,
    a.centro_educativo,
    a.centro_comunitario,
    a.hectareas,
    a.otros,
    a.subsidio_arriendo,
    a.menajes,
    a.ap_aliment,
    a.materiales_const,
    a.sacos,
    a.otros1,
    a.trans_economicas,
    a.recursos_ejecutados
   FROM historico_desastres a
     JOIN divipola b ON b.divipola_id = a.divipola_id
     JOIN eventos e ON e.id = a.evento_id;

ALTER TABLE public.vw_desastres
    OWNER TO group03user;

	