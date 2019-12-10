--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 12.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

--
-- Name: disasters; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.disasters (
    id integer NOT NULL,
    fecha date,
    departamento text,
    municipio text,
    evento text,
    divipola double precision,
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
    recursos_ejecutados double precision
);


ALTER TABLE public.disasters OWNER TO group03user;

--
-- Name: disasters_2017; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.disasters_2017 (
    id integer,
    fecha date,
    departamento text,
    municipio text,
    evento text,
    divipola double precision,
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
    recursos_ejecutados double precision
);


ALTER TABLE public.disasters_2017 OWNER TO group03user;

--
-- Name: disasters_bk; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.disasters_bk (
    id integer,
    fecha date,
    departamento text,
    municipio text,
    evento text,
    divipola double precision,
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
    recursos_ejecutados double precision
);


ALTER TABLE public.disasters_bk OWNER TO group03user;

--
-- Name: disasters_id_seq; Type: SEQUENCE; Schema: public; Owner: group03user
--

CREATE SEQUENCE public.disasters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disasters_id_seq OWNER TO group03user;

--
-- Name: disasters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: group03user
--

ALTER SEQUENCE public.disasters_id_seq OWNED BY public.disasters.id;


--
-- Name: divi_hist_cond_met; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.divi_hist_cond_met (
    divipola_id text,
    hist_cond_met_id integer
);


ALTER TABLE public.divi_hist_cond_met OWNER TO group03user;

--
-- Name: divipola; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.divipola (
    divipola_id text NOT NULL,
    cod_departamento text NOT NULL,
    departamento text NOT NULL,
    cod_municipio text,
    municipio text,
    latitud double precision,
    longitud double precision,
    id_geojson integer
);


ALTER TABLE public.divipola OWNER TO group03user;

--
-- Name: estimacion_poblaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: group03user
--

CREATE SEQUENCE public.estimacion_poblaciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.estimacion_poblaciones_id_seq OWNER TO group03user;

--
-- Name: estimacion_poblaciones; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.estimacion_poblaciones (
    id integer DEFAULT nextval('public.estimacion_poblaciones_id_seq'::regclass) NOT NULL,
    divipola_id text NOT NULL,
    grupos_de_edad text,
    poblacion bigint,
    periodo text,
    genero text
);


ALTER TABLE public.estimacion_poblaciones OWNER TO group03user;

--
-- Name: eventos; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.eventos (
    id integer NOT NULL,
    nombre_evento text NOT NULL,
    categoria text NOT NULL
);


ALTER TABLE public.eventos OWNER TO group03user;

--
-- Name: eventos_id_seq; Type: SEQUENCE; Schema: public; Owner: group03user
--

CREATE SEQUENCE public.eventos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eventos_id_seq OWNER TO group03user;

--
-- Name: eventos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: group03user
--

ALTER SEQUENCE public.eventos_id_seq OWNED BY public.eventos.id;


--
-- Name: hist_cond_met_id_seq; Type: SEQUENCE; Schema: public; Owner: group03user
--

CREATE SEQUENCE public.hist_cond_met_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.hist_cond_met_id_seq OWNER TO group03user;

--
-- Name: historico_cond_meteorologicas; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.historico_cond_meteorologicas (
    id integer DEFAULT nextval('public.hist_cond_met_id_seq'::regclass) NOT NULL,
    fecha date,
    latitud double precision,
    longitud double precision,
    min_temp double precision,
    max_temp double precision,
    precipitacion double precision
);


ALTER TABLE public.historico_cond_meteorologicas OWNER TO group03user;

--
-- Name: historico_desastres_id_seq; Type: SEQUENCE; Schema: public; Owner: group03user
--

CREATE SEQUENCE public.historico_desastres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.historico_desastres_id_seq OWNER TO group03user;

--
-- Name: historico_desastres; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.historico_desastres (
    id integer DEFAULT nextval('public.historico_desastres_id_seq'::regclass) NOT NULL,
    divipola_id text NOT NULL,
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
    departamento_otros text,
    municipio_otros text
);


ALTER TABLE public.historico_desastres OWNER TO group03user;

--
-- Name: historico_desastres_07dec19; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.historico_desastres_07dec19 (
    id integer,
    divipola_id text,
    evento_id integer,
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
    departamento_otros text,
    municipio_otros text
);


ALTER TABLE public.historico_desastres_07dec19 OWNER TO group03user;

--
-- Name: historico_desastres_10dec19; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.historico_desastres_10dec19 (
    id integer,
    divipola_id text,
    evento_id integer,
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
    departamento_otros text,
    municipio_otros text
);


ALTER TABLE public.historico_desastres_10dec19 OWNER TO group03user;

--
-- Name: load_disasters; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.load_disasters (
    fecha timestamp without time zone,
    departamento text,
    municipio text,
    evento text,
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
);


ALTER TABLE public.load_disasters OWNER TO group03user;

--
-- Name: load_disasters_2017; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.load_disasters_2017 (
    fecha timestamp without time zone,
    departamento text,
    municipio text,
    evento text,
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
);


ALTER TABLE public.load_disasters_2017 OWNER TO group03user;

--
-- Name: load_divipola; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.load_divipola (
    cod_depto text,
    cod_mun text,
    depto text,
    mun text
);


ALTER TABLE public.load_divipola OWNER TO group03user;

--
-- Name: load_divipola_geojson; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.load_divipola_geojson (
    id integer,
    cod_departamento text,
    departamento text,
    porc_pob_expuesta double precision,
    id_geojson integer
);


ALTER TABLE public.load_divipola_geojson OWNER TO group03user;

--
-- Name: load_divipola_latlong; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.load_divipola_latlong (
    cod_depto text,
    cod_mun text,
    cod_centro_pobl text,
    depto text,
    municipio text,
    centro_poblado text,
    tipo_centro_poblado text,
    longitud double precision,
    latitud double precision
);


ALTER TABLE public.load_divipola_latlong OWNER TO group03user;

--
-- Name: load_indice_riesgo; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.load_indice_riesgo (
    divipola text,
    municipio text,
    cod_depto text,
    depto text,
    indice_capacidades double precision,
    distancia_euclidiana double precision,
    indice_riesgo double precision,
    indice_riesgo_ajustado_cap double precision,
    ranking_inidice_riesgo_aj double precision
);


ALTER TABLE public.load_indice_riesgo OWNER TO group03user;

--
-- Name: load_maxtemp; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.load_maxtemp (
    date_temp date,
    latitude double precision,
    longitude double precision,
    maxtemp double precision
);


ALTER TABLE public.load_maxtemp OWNER TO group03user;

--
-- Name: load_mintemp; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.load_mintemp (
    date_temp date,
    latitude double precision,
    longitude double precision,
    mintemp double precision
);


ALTER TABLE public.load_mintemp OWNER TO group03user;

--
-- Name: load_pobla_vul_depto; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.load_pobla_vul_depto (
    departamento text,
    porc_pob_expuesta text,
    cod_depto text
);


ALTER TABLE public.load_pobla_vul_depto OWNER TO group03user;

--
-- Name: load_populations; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.load_populations (
    codigo text,
    departamento text,
    grupos_de_edad text,
    poblacion bigint,
    periodo text,
    genero text
);


ALTER TABLE public.load_populations OWNER TO group03user;

--
-- Name: load_precipitaciones; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.load_precipitaciones (
    date_temp date,
    latitude double precision,
    longitude double precision,
    precipitacion double precision
);


ALTER TABLE public.load_precipitaciones OWNER TO group03user;

--
-- Name: populations; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.populations (
    id integer NOT NULL,
    codigo text,
    departamento text,
    grupos_de_edad text,
    poblacion bigint,
    periodo text,
    genero text
);


ALTER TABLE public.populations OWNER TO group03user;

--
-- Name: populations_id_seq; Type: SEQUENCE; Schema: public; Owner: group03user
--

CREATE SEQUENCE public.populations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.populations_id_seq OWNER TO group03user;

--
-- Name: populations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: group03user
--

ALTER SEQUENCE public.populations_id_seq OWNED BY public.populations.id;


--
-- Name: riesgo_indices_seq; Type: SEQUENCE; Schema: public; Owner: group03user
--

CREATE SEQUENCE public.riesgo_indices_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.riesgo_indices_seq OWNER TO group03user;

--
-- Name: riesgo_indices; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.riesgo_indices (
    id integer DEFAULT nextval('public.riesgo_indices_seq'::regclass) NOT NULL,
    divipola_id text,
    indice_capacidades double precision,
    distancia_euclidiana double precision,
    indice_riesgo double precision,
    indice_riesgo_ajustado_cap double precision,
    ranking_inidice_riesgo_aj double precision,
    porc_pob_expuesta double precision
);


ALTER TABLE public.riesgo_indices OWNER TO group03user;

--
-- Name: tmp_caso1_1_allmunicipios; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.tmp_caso1_1_allmunicipios (
    fecha timestamp without time zone,
    departamento text,
    mun_depto text,
    municipio text,
    evento text,
    num_mun bigint,
    least_ind double precision,
    muertos double precision,
    muertos_new double precision,
    heridos double precision,
    heridos_new double precision,
    desapa double precision,
    desapa_new double precision,
    personas double precision,
    personas_new double precision,
    familias double precision,
    familias_new double precision,
    viviendasdestru double precision,
    viviendasdestru_new double precision,
    viviendasaver double precision,
    viviendasaver_new double precision
);


ALTER TABLE public.tmp_caso1_1_allmunicipios OWNER TO group03user;

--
-- Name: tmp_caso1_allmunicipios; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.tmp_caso1_allmunicipios (
    fecha timestamp without time zone,
    departamento text,
    mun_depto text,
    municipio text,
    evento text,
    num_mun bigint,
    least_ind double precision,
    muertos double precision,
    muertos_new double precision,
    heridos double precision,
    heridos_new double precision,
    desapa double precision,
    desapa_new double precision,
    personas double precision,
    personas_new double precision,
    familias double precision,
    familias_new double precision,
    viviendasdestru double precision,
    viviendasdestru_new double precision,
    viviendasaver double precision,
    viviendasaver_new double precision
);


ALTER TABLE public.tmp_caso1_allmunicipios OWNER TO group03user;

--
-- Name: tmp_caso2; Type: TABLE; Schema: public; Owner: group03user
--

CREATE TABLE public.tmp_caso2 (
    municipio_new text,
    departamento_new text,
    num_mun integer,
    fecha timestamp without time zone,
    departamento text,
    municipio text,
    evento text,
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
);


ALTER TABLE public.tmp_caso2 OWNER TO group03user;

--
-- Name: vw_desastres; Type: VIEW; Schema: public; Owner: group03user
--

CREATE VIEW public.vw_desastres AS
 SELECT a.id,
    a.fecha,
    COALESCE(b.departamento, a.departamento_otros) AS departamento,
    COALESCE(b.municipio, a.municipio_otros) AS municipio,
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
    a.recursos_ejecutados,
    b.divipola_id
   FROM ((public.historico_desastres a
     LEFT JOIN public.divipola b ON ((b.divipola_id = a.divipola_id)))
     LEFT JOIN public.eventos e ON ((e.id = a.evento_id)));


ALTER TABLE public.vw_desastres OWNER TO group03user;

--
-- Name: disasters id; Type: DEFAULT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.disasters ALTER COLUMN id SET DEFAULT nextval('public.disasters_id_seq'::regclass);


--
-- Name: eventos id; Type: DEFAULT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.eventos ALTER COLUMN id SET DEFAULT nextval('public.eventos_id_seq'::regclass);


--
-- Name: populations id; Type: DEFAULT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.populations ALTER COLUMN id SET DEFAULT nextval('public.populations_id_seq'::regclass);


--
-- Name: disasters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: group03user
--

SELECT pg_catalog.setval('public.disasters_id_seq', 38626, true);


--
-- Name: estimacion_poblaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: group03user
--

SELECT pg_catalog.setval('public.estimacion_poblaciones_id_seq', 66096, true);


--
-- Name: eventos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: group03user
--

SELECT pg_catalog.setval('public.eventos_id_seq', 65, true);


--
-- Name: hist_cond_met_id_seq; Type: SEQUENCE SET; Schema: public; Owner: group03user
--

SELECT pg_catalog.setval('public.hist_cond_met_id_seq', 1140720, true);


--
-- Name: historico_desastres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: group03user
--

SELECT pg_catalog.setval('public.historico_desastres_id_seq', 42763, true);


--
-- Name: populations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: group03user
--

SELECT pg_catalog.setval('public.populations_id_seq', 66096, true);


--
-- Name: riesgo_indices_seq; Type: SEQUENCE SET; Schema: public; Owner: group03user
--

SELECT pg_catalog.setval('public.riesgo_indices_seq', 1155, true);


--
-- Name: disasters disasters_pkey; Type: CONSTRAINT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.disasters
    ADD CONSTRAINT disasters_pkey PRIMARY KEY (id);


--
-- Name: divipola divipola_pkey; Type: CONSTRAINT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.divipola
    ADD CONSTRAINT divipola_pkey PRIMARY KEY (divipola_id);


--
-- Name: estimacion_poblaciones estimacion_poblaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.estimacion_poblaciones
    ADD CONSTRAINT estimacion_poblaciones_pkey PRIMARY KEY (id);


--
-- Name: eventos eventos_pkey; Type: CONSTRAINT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.eventos
    ADD CONSTRAINT eventos_pkey PRIMARY KEY (id);


--
-- Name: historico_cond_meteorologicas historico_cond_met_pkey; Type: CONSTRAINT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.historico_cond_meteorologicas
    ADD CONSTRAINT historico_cond_met_pkey PRIMARY KEY (id);


--
-- Name: historico_desastres historico_desastres_pkey; Type: CONSTRAINT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.historico_desastres
    ADD CONSTRAINT historico_desastres_pkey PRIMARY KEY (id);


--
-- Name: populations populations_pkey; Type: CONSTRAINT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.populations
    ADD CONSTRAINT populations_pkey PRIMARY KEY (id);


--
-- Name: riesgo_indices riesgo_indices_pkey; Type: CONSTRAINT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.riesgo_indices
    ADD CONSTRAINT riesgo_indices_pkey PRIMARY KEY (id);


--
-- Name: fki_estpob_divipola__id_fk; Type: INDEX; Schema: public; Owner: group03user
--

CREATE INDEX fki_estpob_divipola__id_fk ON public.estimacion_poblaciones USING btree (divipola_id);


--
-- Name: fki_histdes_divipola_id_fk; Type: INDEX; Schema: public; Owner: group03user
--

CREATE INDEX fki_histdes_divipola_id_fk ON public.historico_desastres USING btree (divipola_id);


--
-- Name: fki_histdes_evento_id_fk; Type: INDEX; Schema: public; Owner: group03user
--

CREATE INDEX fki_histdes_evento_id_fk ON public.historico_desastres USING btree (evento_id);


--
-- Name: estimacion_poblaciones estpob_divipola__id_fk; Type: FK CONSTRAINT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.estimacion_poblaciones
    ADD CONSTRAINT estpob_divipola__id_fk FOREIGN KEY (divipola_id) REFERENCES public.divipola(divipola_id);


--
-- Name: historico_desastres histdes_divipola_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.historico_desastres
    ADD CONSTRAINT histdes_divipola_id_fk FOREIGN KEY (divipola_id) REFERENCES public.divipola(divipola_id);


--
-- Name: historico_desastres histdes_evento_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: group03user
--

ALTER TABLE ONLY public.historico_desastres
    ADD CONSTRAINT histdes_evento_id_fk FOREIGN KEY (evento_id) REFERENCES public.eventos(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM rdsadmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

