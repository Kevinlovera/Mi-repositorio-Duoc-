
/* ---- DEFINIR FORMATO FECHA DD/MM/YYYY ---- */
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';


/* ---- BORRADO DE OBJETOS ---- */
DROP TABLE sucursal CASCADE CONSTRAINTS;
DROP TABLE comision CASCADE CONSTRAINTS;
DROP TABLE detalle_prop_arrendadas CASCADE CONSTRAINTS;
DROP TABLE resumen_prop_arrendadas CASCADE CONSTRAINTS;
DROP TABLE empleados_por_sucursal CASCADE CONSTRAINTS;
DROP TABLE resumen_pagos_por_sucursal CASCADE CONSTRAINTS;
DROP TABLE arriendo_propiedad CASCADE CONSTRAINTS;
DROP TABLE propiedad CASCADE CONSTRAINTS;
DROP TABLE empleado CASCADE CONSTRAINTS;
DROP TABLE propietario CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE tipo_propiedad CASCADE CONSTRAINTS;
DROP TABLE comuna CASCADE CONSTRAINTS;
DROP TABLE categoria_empleado CASCADE CONSTRAINTS;
DROP TABLE haberes CASCADE CONSTRAINTS;
DROP TABLE descuentos CASCADE CONSTRAINTS;
DROP SEQUENCE seq_cat;
DROP SEQUENCE seq_com;
DROP SEQUENCE seq_emp_sec;
DROP SEQUENCE seq_det_prop_arriendo;
DROP SEQUENCE seq_res_prop_arriendo;
 
/* ---- CREACI�N DE OBJETOS ---- */
CREATE SEQUENCE seq_cat;
CREATE SEQUENCE seq_com START WITH 80;
CREATE SEQUENCE seq_emp_sec;
CREATE SEQUENCE seq_det_prop_arriendo;
CREATE SEQUENCE seq_res_prop_arriendo;

CREATE TABLE comuna (
  id_comuna     NUMBER(3) NOT NULL,
  nombre_comuna VARCHAR2(30) NOT NULL,
  CONSTRAINT pk_comuna PRIMARY KEY ( id_comuna )
);

CREATE TABLE sucursal (
  id_sucursal        NUMBER(3) NOT NULL,
  desc_sucursal      VARCHAR2(30) NOT NULL,
  direccion_sucursal VARCHAR2(30) NOT NULL,
  id_comuna          NUMBER(3) NOT NULL,
  CONSTRAINT pk_sucursal PRIMARY KEY ( id_sucursal )
);

CREATE TABLE categoria_empleado (
  id_categoria_emp   NUMBER(1) NOT NULL,
  desc_categoria_emp VARCHAR2(30) NOT NULL,
  CONSTRAINT pk_categoria_empleado PRIMARY KEY ( id_categoria_emp )
);

CREATE TABLE tipo_propiedad (
  id_tipo_propiedad   VARCHAR2(1) NOT NULL,
  desc_tipo_propiedad VARCHAR2(30) NOT NULL,
  CONSTRAINT pk_tipo_propiedad PRIMARY KEY ( id_tipo_propiedad )
);

CREATE TABLE propietario (
  numrut_prop    NUMBER(10) NOT NULL,
  dvrut_prop     VARCHAR2(1) NOT NULL,
  appaterno_prop VARCHAR2(15) NOT NULL,
  apmaterno_prop VARCHAR2(15) NOT NULL,
  nombre_prop    VARCHAR2(25) NOT NULL,
  direccion_prop VARCHAR2(60) NOT NULL,
  fonofijo_prop  VARCHAR2(15) NOT NULL,
  celular_prop   VARCHAR2(15),
  CONSTRAINT pk_propietario PRIMARY KEY ( numrut_prop )
);

CREATE TABLE cliente (
  numrut_cli    NUMBER(10) NOT NULL,
  dvrut_cli     VARCHAR2(1) NOT NULL,
  appaterno_cli VARCHAR2(15) NOT NULL,
  apmaterno_cli VARCHAR2(15) NOT NULL,
  nombre_cli    VARCHAR2(25) NOT NULL,
  direccion_cli VARCHAR2(60) NOT NULL,
  fonofijo_cli  NUMBER(15) NOT NULL,
  celular_cli   NUMBER(15),
  renta_cli     NUMBER(7) NOT NULL,
  CONSTRAINT pk_cliente PRIMARY KEY ( numrut_cli )
);

CREATE TABLE empleado (
  numrut_emp       NUMBER(10) NOT NULL,
  dvrut_emp        VARCHAR2(1) NOT NULL,
  appaterno_emp    VARCHAR2(15) NOT NULL,
  apmaterno_emp    VARCHAR2(15) NOT NULL,
  nombre_emp       VARCHAR2(25) NOT NULL,
  foto_emp         BLOB DEFAULT empty_blob(),
  direccion_emp    VARCHAR2(60) NOT NULL,
  fonofijo_emp     VARCHAR2(15) NOT NULL,
  celular_emp      VARCHAR2(15),
  fecnac_emp       DATE,
  fecing_emp       DATE NOT NULL,
  sueldo_emp       NUMBER(7) NOT NULL,
  id_categoria_emp NUMBER(1),
  id_sucursal      NUMBER(3) NOT NULL,
  CONSTRAINT pk_empleado PRIMARY KEY ( numrut_emp )
);

CREATE TABLE propiedad (
  nro_propiedad       NUMBER(6) NOT NULL,
  direccion_propiedad VARCHAR2(60) NOT NULL,
  superficie          NUMBER(5, 2) NOT NULL,
  nro_dormitorios     NUMBER(1),
  nro_banos           NUMBER(1),
  valor_arriendo      NUMBER(7) NOT NULL,
  valor_gasto_comun   NUMBER(6),
  id_tipo_propiedad   VARCHAR2(1) NOT NULL,
  id_comuna           NUMBER(3) NOT NULL,
  numrut_prop         NUMBER(10) NOT NULL,
  numrut_emp          NUMBER(10),
  CONSTRAINT pk_propiedad PRIMARY KEY ( nro_propiedad )
);

CREATE TABLE arriendo_propiedad (
  nro_propiedad   NUMBER(6) NOT NULL,
  numrut_cli      NUMBER(10) NOT NULL,
  fecini_arriendo DATE NOT NULL,
  fecter_arriendo DATE NULL,
  CONSTRAINT pk_arriendo_propiedad PRIMARY KEY ( nro_propiedad,
                                                 numrut_cli )
);

CREATE TABLE comision (
  nro_tramo          NUMBER(1) NOT NULL
    CONSTRAINT pk_comision PRIMARY KEY,
  total_arriendo_inf NUMBER(2) NOT NULL,
  total_arriendo_sup NUMBER(2) NOT NULL,
  valor_comision     NUMBER(10) NOT NULL
);

CREATE TABLE empleados_por_sucursal (
  correl_emp_suc           NUMBER(3) NOT NULL,
  desc_sucursal            VARCHAR2(30) NOT NULL,
  total_empleados          NUMBER(5) NOT NULL,
  total_emp_igual_menor_40 NUMBER(3) NOT NULL,
  total_emp_mayor_40       NUMBER(3) NOT NULL,
  CONSTRAINT pk_empleados_por_suc PRIMARY KEY ( correl_emp_suc )
);

CREATE TABLE haberes (
  numrut_emp        NUMBER(10) NOT NULL,
  id_sucursal       NUMBER(3) NOT NULL,
  mes_proceso       NUMBER(2) NOT NULL,
  anno_proceso      NUMBER(4) NOT NULL,
  sueldo_base       NUMBER(8) NOT NULL,
  comision_arriendo NUMBER(8) NOT NULL,
  colacion          NUMBER(8) NOT NULL,
  movilizacion      NUMBER(8) NOT NULL,
  CONSTRAINT pk_haberes PRIMARY KEY ( numrut_emp,
                                      mes_proceso,
                                      anno_proceso )
);

CREATE TABLE descuentos (
  numrut_emp   NUMBER(10) NOT NULL,
  id_sucursal  NUMBER(3) NOT NULL,
  mes_proceso  NUMBER(2) NOT NULL,
  anno_proceso NUMBER(4) NOT NULL,
  prevision    NUMBER(8) NOT NULL,
  salud        NUMBER(8) NOT NULL,
  CONSTRAINT pk_descuentos PRIMARY KEY ( numrut_emp,
                                         mes_proceso,
                                         anno_proceso )
);

CREATE TABLE resumen_pagos_por_sucursal (
  id_sucursal      NUMBER(3) NOT NULL,
  mes_proceso      NUMBER(2) NOT NULL,
  anno_proceso     NUMBER(4) NOT NULL,
  total_empleados  NUMBER(3) NOT NULL,
  total_haberes    NUMBER(10) NOT NULL,
  total_descuentos NUMBER(10) NOT NULL,
  CONSTRAINT pk_resumen_pagos_por_suc PRIMARY KEY ( id_sucursal,
                                                    mes_proceso,
                                                    anno_proceso )
);

CREATE TABLE detalle_prop_arrendadas (
  correl_det_prop      NUMBER(4) NOT NULL,
  desc_tipo_propiedad  VARCHAR2(30) NOT NULL,
  nro_propiedad        NUMBER(6) NOT NULL,
  direccion_propiedad  VARCHAR2(60) NOT NULL,
  valor_arriendo       NUMBER(7) NOT NULL,
  fec_inicio_arriendo  DATE NOT NULL,
  fec_termino_arriendo DATE NULL,
  fecha_proceso        DATE NOT NULL,
  CONSTRAINT pk_detalle_prop_arrendadas PRIMARY KEY ( correl_det_prop )
);

CREATE TABLE resumen_prop_arrendadas (
  correl_res_prop                NUMBER(4) NOT NULL,
  desc_tipo_propiedad            VARCHAR2(30) NOT NULL,
  total_propiedades              NUMBER(3) NOT NULL,
  total_propiedades_arrendadas   NUMBER(3) NOT NULL,
  total_propiedades_sin_arrendar NUMBER(3) NOT NULL,
  fecha_proceso                  DATE NOT NULL,
  CONSTRAINT pk_resumen_prop_arrendadas PRIMARY KEY ( correl_res_prop )
);

-- creacion de llaves foraneas 
ALTER TABLE sucursal
  ADD CONSTRAINT fk_sucursal_comuna FOREIGN KEY ( id_comuna )
    REFERENCES comuna ( id_comuna );

ALTER TABLE empleado
  ADD CONSTRAINT fk_empleado_sucursal FOREIGN KEY ( id_sucursal )
    REFERENCES sucursal ( id_sucursal );

ALTER TABLE empleado
  ADD CONSTRAINT fk_empleado_categoria_empleado FOREIGN KEY ( id_categoria_emp )
    REFERENCES categoria_empleado ( id_categoria_emp );

ALTER TABLE propiedad
  ADD CONSTRAINT fk_propiedad_tipo_propiedad FOREIGN KEY ( id_tipo_propiedad )
    REFERENCES tipo_propiedad ( id_tipo_propiedad );

ALTER TABLE propiedad
  ADD CONSTRAINT fk_propiedad_comuna FOREIGN KEY ( id_comuna )
    REFERENCES comuna ( id_comuna );

ALTER TABLE propiedad
  ADD CONSTRAINT fk_propiedad_propietario FOREIGN KEY ( numrut_prop )
    REFERENCES propietario ( numrut_prop );

ALTER TABLE propiedad
  ADD CONSTRAINT fk_propiedad_empleado FOREIGN KEY ( numrut_emp )
    REFERENCES empleado ( numrut_emp );

ALTER TABLE arriendo_propiedad
  ADD CONSTRAINT fk_arriendo_prop_propiedad FOREIGN KEY ( nro_propiedad )
    REFERENCES propiedad ( nro_propiedad );

ALTER TABLE arriendo_propiedad
  ADD CONSTRAINT fk_arriendo_prop_cliente FOREIGN KEY ( numrut_cli )
    REFERENCES cliente ( numrut_cli );

ALTER TABLE haberes
  ADD CONSTRAINT fk_haberes_empleados FOREIGN KEY ( numrut_emp )
    REFERENCES empleado ( numrut_emp );

ALTER TABLE descuentos
  ADD CONSTRAINT fk_descuentos_empleados FOREIGN KEY ( numrut_emp )
    REFERENCES empleado ( numrut_emp );

ALTER TABLE detalle_prop_arrendadas
  ADD CONSTRAINT fk_detalle_prop_arrendadas FOREIGN KEY ( nro_propiedad )
    REFERENCES propiedad ( nro_propiedad );

ALTER TABLE resumen_pagos_por_sucursal
  ADD CONSTRAINT fk_res_pagos_sucursal_sucursal FOREIGN KEY ( id_sucursal )
    REFERENCES sucursal ( id_sucursal );
 
-- insercion de datos
INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Las Condes'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Providencia'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Santiago'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  '�u�oa'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Vitacura'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'La Reina'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'La Florida'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Maip�'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Lo Barnechea'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Macul'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'San Miguel'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Pe�alol�n'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Puente Alto'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Recoleta'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Estaci�n Central'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'San Bernardo'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Independencia'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'La Cisterna'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Quilicura'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Quinta Normal'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Conchal�'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'San Joaqu�n'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Huechuraba'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'El Bosque'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Cerrillos'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Cerro Navia'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'La Granja'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'La Pintana'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Lo Espejo'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Lo Prado'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Pedro Aguirre Cerda'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Pudahuel'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Renca'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'San Ram�n'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Melipilla'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'San Pedro'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Alhu�'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Mar�a Pinto'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Curacav�'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Talagante'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'El Monte'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Buin'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Paine'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Pe�aflor'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Isla de Maipo'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Colina'
);

INSERT INTO comuna VALUES (
  seq_com.NEXTVAL,
  'Pirque'
);

INSERT INTO sucursal VALUES (
  10,
  'Sucursal Las Condes',
  'Avda. Apoquindo 6282',
  80
);

INSERT INTO sucursal VALUES (
  20,
  'Susursal Santiago Centro',
  'San Isidro 106',
  82
);

INSERT INTO sucursal VALUES (
  30,
  'Sucursal Providencia',
  'Pedro de Valdivia 999',
  81
);

INSERT INTO sucursal VALUES (
  40,
  'Sucursal Vitacura',
  'Av. Alonso de C�rdova 4222',
  84
);

INSERT INTO categoria_empleado VALUES (
  seq_cat.NEXTVAL,
  'Gerente'
);

INSERT INTO categoria_empleado VALUES (
  seq_cat.NEXTVAL,
  'Supervisor'
);

INSERT INTO categoria_empleado VALUES (
  seq_cat.NEXTVAL,
  'Ejecutivo de Arriendo'
);

INSERT INTO categoria_empleado VALUES (
  seq_cat.NEXTVAL,
  'Auxiliar'
);

INSERT INTO tipo_propiedad VALUES (
  'A',
  'CASA'
);

INSERT INTO tipo_propiedad VALUES (
  'B',
  'DEPARTAMENTO'
);

INSERT INTO tipo_propiedad VALUES (
  'C',
  'LOCAL'
);

INSERT INTO tipo_propiedad VALUES (
  'D',
  'PARCELA SIN CASA'
);

INSERT INTO tipo_propiedad VALUES (
  'E',
  'PARCELA CON CASA'
);

INSERT INTO empleado VALUES (
  11649964,
  '0',
  'GALVEZ',
  'CASTRO',
  'MARTA',
  empty_blob(),
  'CLOVIS MONTERO 0260 D/202',
  '23417556',
  '25273328',
  '20121971',
  '01071994',
  1515239,
  1,
  10
);

INSERT INTO empleado VALUES (
  12113369,
  '4',
  'ROMERO',
  'DIAZ',
  'NANCY',
  empty_blob(),
  'TENIENTE RAMON JIMENEZ 4753',
  '25631567',
  '22623877',
  '09011968',
  '01081989',
  2710153,
  3,
  20
);

INSERT INTO empleado VALUES (
  12456905,
  '1',
  'CANALES',
  'BASTIAS',
  'JORGE',
  empty_blob(),
  'GENERAL CONCHA PEDREGAL #885',
  '27779827',
  '27413395',
  '21121957',
  '01091981',
  2945675,
  3,
  30
);

INSERT INTO empleado VALUES (
  12466553,
  '2',
  'VIDAL',
  'PEREZ',
  'TERESA',
  empty_blob(),
  'FCO. DE CAMARGO 14515 D/14',
  '28583700',
  '28122603',
  '20/12/1975',
  '01081994',
  1202614,
  3,
  40
);

INSERT INTO empleado VALUES (
  11745244,
  '3',
  'VENEGAS',
  'SOTO',
  'KARINA',
  empty_blob(),
  'ARICA 3850',
  '27790734',
  '27494190',
  '23121963',
  '01081986',
  1439042,
  3,
  10
);

INSERT INTO empleado VALUES (
  11999100,
  '4',
  'CONTRERAS',
  'CASTILLO',
  'CLAUDIO',
  empty_blob(),
  'ISABEL RIQUELME 6075',
  '27764142',
  '25232677',
  '24121966',
  '01081992',
  364163,
  4,
  20
);

INSERT INTO empleado VALUES (
  12888868,
  '5',
  'PAEZ',
  'MACMILLAN',
  'JOSE',
  empty_blob(),
  'FERNANDEZ CONCHA 500',
  '22399493',
  '27735417',
  '25121964',
  '01031989',
  1896155,
  3,
  20
);

INSERT INTO empleado VALUES (
  12811094,
  '6',
  'MOLINA',
  'GONZALEZ',
  'PAULA',
  empty_blob(),
  'PJE.TIMBAL 1095 V/POMAIRE',
  '25313830',
  NULL,
  '26121978',
  '01042016',
  1757577,
  3,
  30
);

INSERT INTO empleado VALUES (
  14255602,
  '7',
  'MU�OZ',
  'ROJAS',
  'CARLOTA',
  empty_blob(),
  'TERCEIRA 7426 V/LIBERTAD',
  '26490093',
  '27414886',
  '27121982',
  '01052004',
  2658577,
  2,
  10
);

INSERT INTO empleado VALUES (
  11630572,
  '8',
  'ARAVENA',
  'HERBAGE',
  'GUSTAVO',
  empty_blob(),
  'FERNANDO DE ARAGON 8420',
  '25588481',
  '26256661',
  '15/09/1989',
  '01071999',
  1957095,
  3,
  40
);

INSERT INTO empleado VALUES (
  11636534,
  '9',
  'ADASME',
  'ZU�IGA',
  'LUIS',
  empty_blob(),
  'LITTLE ROCK 117 V/PDTE.KENNEDY',
  '26483081',
  '26213403',
  '29121973',
  '01061994',
  1614934,
  3,
  10
);

INSERT INTO empleado VALUES (
  12272880,
  'K',
  'LAPAZ',
  'SEPULVEDA',
  'MARCO',
  empty_blob(),
  'GUARDIA MARINA. RIQUELME 561',
  '26038967',
  '22814034',
  '30121989',
  '01072015',
  1352596,
  3,
  40
);

INSERT INTO empleado VALUES (
  11846972,
  '5',
  'OGAZ',
  'VARAS',
  'MARCO',
  empty_blob(),
  'OVALLE N�5798 V/ OHIGGINS',
  '27763209',
  '27377830',
  '31121959',
  '01042015',
  253590,
  4,
  20
);

INSERT INTO empleado VALUES (
  14283083,
  '6',
  'MONDACA',
  'COLLAO',
  'AUGUSTO',
  empty_blob(),
  'NUEVA COLON N�1152',
  '27357104',
  '25376873',
  '01011989',
  '01092011',
  1144245,
  2,
  30
);

INSERT INTO empleado VALUES (
  14541837,
  '7',
  'ALVAREZ',
  'RIVERA',
  'MARCO',
  empty_blob(),
  'HONDURAS B/8908 D/102 L.BRISAS',
  '22875902',
  '25292497',
  '02011977',
  '01101994',
  1541418,
  3,
  30
);

INSERT INTO empleado VALUES (
  12482036,
  '8',
  'OLAVE',
  'CASTILLO',
  'ADRIAN',
  empty_blob(),
  'ELISA CORREA 188',
  '22888897',
  '28441077',
  '03011956',
  '01111984',
  1068086,
  3,
  30
);

INSERT INTO empleado VALUES (
  12468081,
  '9',
  'SANCHEZ',
  'GONZALEZ',
  'PAOLA',
  empty_blob(),
  'AV.OSSA 01240 V/MI VI�ITA',
  '25273328',
  '25581593',
  '04011987',
  '01082010',
  1330355,
  3,
  10
);

INSERT INTO empleado VALUES (
  12260812,
  '0',
  'RIOS',
  'ZU�IGA',
  'RAFAEL',
  empty_blob(),
  'LOS CASTA�OS 1427 VILLA C.C.U.',
  '26410462',
  '28501857',
  '05011991',
  '01032011',
  367056,
  4,
  30
);

INSERT INTO empleado VALUES (
  12899759,
  '1',
  'CACERES',
  'JIMENEZ',
  'ERIKA',
  empty_blob(),
  'PJE.NAVARINO 15758 V/P.DE O�A',
  '28593881',
  '22650316',
  '06011974',
  '01121992',
  2281415,
  3,
  40
);

INSERT INTO empleado VALUES (
  12868553,
  '2',
  'CHACON',
  'AMAYA',
  'PATRICIA',
  empty_blob(),
  'LO ERRAZURIZ 530 V/EL SENDERO',
  '25577963',
  NULL,
  '07011985',
  '01012004',
  1723055,
  3,
  40
);

INSERT INTO empleado VALUES (
  12648200,
  '3',
  'NARVAEZ',
  'MU�OZ',
  'LUIS',
  empty_blob(),
  'AMBRIOSO OHIGGINS  2010',
  '27742268',
  '25317272',
  '08011993',
  '01032016',
  1966613,
  3,
  30
);

INSERT INTO empleado VALUES (
  11670042,
  '5',
  'GONGORA',
  'DEVIA',
  'VALESKA',
  empty_blob(),
  'PASAJE VENUS 2765',
  '23244270',
  '26224817',
  '10011975',
  '01091996',
  1635086,
  3,
  10
);

INSERT INTO empleado VALUES (
  12642309,
  'K',
  'NAVARRO',
  'SANTIBA�EZ',
  'JUAN',
  empty_blob(),
  'SANTA ELENA 300 V/LOS ALAMOS',
  '27441530',
  '25342599',
  '11011986',
  '02092009',
  1659230,
  3,
  10
);

INSERT INTO cliente VALUES (
  10639521,
  '0',
  'UVAL',
  'RIQUELME',
  'MIGUEL',
  'SAN PABLO 7545 B/2 DPTO. 12',
  '26439756',
  '52710253',
  300000
);

INSERT INTO cliente VALUES (
  13074837,
  '1',
  'AMENGUAL',
  'SALDIAS',
  'CESAR',
  'PJE.CODORNICES 1550 V/EL RODEO',
  '22168405',
  '55212406',
  400000
);

INSERT INTO cliente VALUES (
  12251882,
  '2',
  'MORICE',
  'DONOSO',
  'CLAUDIO',
  'CHACALLUTA 9519',
  '22814948',
  '77413705',
  200000
);

INSERT INTO cliente VALUES (
  10238830,
  '3',
  'SOTO',
  'ARMAZAN',
  'JUAN',
  'LOS MORELOS 803',
  '25237022',
  '92853737',
  200000
);

INSERT INTO cliente VALUES (
  12777063,
  '4',
  'VILLENA',
  'CAVERO',
  'PABLO',
  'NAVIDAD 1345 SEC.LA PALMILLA',
  '26234565',
  '27497042',
  600000
);

INSERT INTO cliente VALUES (
  12467572,
  '5',
  'RIQUELME',
  'BRIGNARDELLO',
  'MIGUEL',
  'AMERICO VESPUCIO 1505 V/MEXICO',
  '25381416',
  '52794874',
  500000
);

INSERT INTO cliente VALUES (
  12866487,
  '6',
  'STOLLER',
  'VARGAS',
  'LORENA',
  'PASCUAL BABURIZZA 655',
  '22773144',
  '85450443',
  250000
);

INSERT INTO cliente VALUES (
  13463138,
  '7',
  'BRAVO',
  'HENRIQUEZ',
  'PABLO',
  'FLACO MARIN #107 V/ C. NORTE',
  '27766349',
  '55341874',
  380000
);

INSERT INTO cliente VALUES (
  11657132,
  '8',
  'ACU�A',
  'BARRERA',
  'RONNY',
  'OBS.ASTRONOMICO UC PAR.METROP.',
  '27370770',
  '62737281',
  420000
);

INSERT INTO cliente VALUES (
  12487147,
  '9',
  'MARIN',
  'ARAVENA',
  'JUAN',
  'LAS PALMAS 134 V/CALIFORNIA',
  '27780321',
  '97773749',
  560000
);

INSERT INTO cliente VALUES (
  12817700,
  'K',
  'VARGAS',
  'GARAY',
  'CLAUDIA',
  'PJE.BELEN N�8 P/GERALDINE',
  '2425678',
  '88122441',
  400000
);

INSERT INTO cliente VALUES (
  9499044,
  '5',
  'ROJAS',
  'ACHA',
  'CLAUDIO',
  'DR LUIS BISQUERT 2924 DPTO. 4',
  '22380333',
  '25262465',
  300000
);

INSERT INTO cliente VALUES (
  11996940,
  '6',
  'ORELLANA',
  'SAAVEDRA',
  'JUAN',
  'SANTA MARTA 9415 P/STA. TERESA',
  '56434256',
  '25421693',
  200000
);

INSERT INTO cliente VALUES (
  14558221,
  '7',
  'PASTEN',
  'JORQUERA',
  'ALAN',
  'BALMACEDA N�15',
  '28421196',
  '62278556',
  180000
);

INSERT INTO cliente VALUES (
  12459100,
  '8',
  'POBLETE',
  'FUENTES',
  'SERGIO',
  'TINGUIRIRICA 3553 V/FORESTA',
  '27464857',
  '75631102',
  340000
);

INSERT INTO cliente VALUES (
  8716085,
  '9',
  'HORMAZABAL',
  'SAGREDO',
  'HUGO',
  'DORSAL 5912 V/MANUEL RODRIGUEZ',
  '27789260',
  '76432652',
  260000
);

INSERT INTO cliente VALUES (
  12503185,
  '0',
  'SILVA',
  'GONZALEZ',
  'PAUL',
  'CALLE HOLANDA 073 V/PORVENIR',
  '28509240',
  '67416145',
  300000
);

INSERT INTO cliente VALUES (
  10586995,
  '1',
  'MU�OZ',
  'FERNANDEZ',
  'JOSE',
  'AV.LAS TORRES 152',
  '26434104',
  NULL,
  1200000
);

INSERT INTO cliente VALUES (
  11949670,
  '2',
  'CONTRERAS',
  'MIRANDA',
  'CLAUDIO',
  'VISTA HERMOSA 2126 P/H.ALTO',
  '28310255',
  '65582082',
  500000
);

INSERT INTO cliente VALUES (
  9771046,
  '3',
  'ZAMORANO',
  'ELIZONDO',
  'LUIS',
  'ALAMEDA 301',
  '26332876',
  '52811129',
  320000
);

INSERT INTO cliente VALUES (
  12095272,
  '4',
  'ROJAS',
  'RODRIGUEZ',
  'DAMASO',
  'URMENETA 1124 D.302',
  '26210614',
  NULL,
  160000
);

INSERT INTO cliente VALUES (
  14632410,
  '5',
  'VILLANUEVA',
  'YEPES',
  'MONICA',
  'GASPAR DE LA BARRERA 2815',
  '26830779',
  '56832705',
  240000
);

INSERT INTO cliente VALUES (
  15353262,
  'K',
  'BARRIOS',
  'HIDALGO',
  'LUIS',
  'BALMACEDA 966',
  '28213310',
  '96255762',
  260000
);

INSERT INTO cliente VALUES (
  4604866,
  '0',
  'AGUIRRE',
  'MU�OZ',
  'LUIS',
  'VICHUQUEN 1462',
  '26238494',
  NULL,
  300000
);

INSERT INTO cliente VALUES (
  14148957,
  '1',
  'MARTIN',
  'DONOSO',
  'JUAN',
  'PJE. LOS FLORENTINOS 1804',
  '25428017',
  '82936654',
  400000
);

INSERT INTO cliente VALUES (
  12831482,
  '2',
  'ORELLANA',
  'GARRIDO',
  'PATRICIO',
  'LOS GUAITECAS 1751',
  '28572849',
  '76442200',
  200000
);

INSERT INTO cliente VALUES (
  12186256,
  '3',
  'FUENTES',
  'MORENO',
  'MANUEL',
  'HANOI 7474',
  '26493855',
  '55311880',
  200000
);

INSERT INTO cliente VALUES (
  11976208,
  '4',
  'OPAZO',
  'AGUILERA',
  'MARIA',
  'LOS TILOS 8924 P/LUIS BELTRAN',
  '26442611',
  '65351928',
  600000
);

INSERT INTO cliente VALUES (
  12998853,
  '5',
  'TRINKE',
  'TRINKE',
  'CRISTIAN',
  'MANCO CAPAC 1756',
  '27461014',
  '67765258',
  500000
);

INSERT INTO cliente VALUES (
  12947165,
  '6',
  'HISI',
  'DIAZ',
  'ROSA',
  'ICARO 3580 V/SANTA INES',
  '27360251',
  '52893123',
  250000
);

INSERT INTO cliente VALUES (
  13043565,
  '7',
  'AGUILERA',
  'ROMAN',
  'WILLIBALDO',
  'ANDES 4717',
  '27748105',
  '55285702',
  380000
);

INSERT INTO cliente VALUES (
  13072743,
  '8',
  'ORELLANA',
  'SERQUEIRA',
  'JAIME',
  'AV. 5 DE ABRIL 5693 A DPTO. 42',
  '27417338',
  '8491680',
  420000
);

INSERT INTO cliente VALUES (
  16960649,
  '9',
  'RIQUELME',
  'CHAVEZ',
  'ROCIO',
  'BALMACEDA 1070',
  '28598452',
  '92871989',
  560000
);

INSERT INTO cliente VALUES (
  12468646,
  'K',
  'ALVAREZ',
  'MU�OZ',
  'MANUEL',
  'EDUARDO MATTE 2180',
  '25557973',
  '95292190',
  400000
);

INSERT INTO cliente VALUES (
  12656375,
  '5',
  'SALDIAS',
  'ROJAS',
  'DAVID',
  'LOS TURISTAS 0735 P/EL SALTO',
  '26224280',
  NULL,
  300000
);

INSERT INTO cliente VALUES (
  11635470,
  '6',
  'RAMIREZ',
  'GUTIERREZ',
  'JOEL',
  'SIERRA BELLA 1687',
  '25225838',
  NULL,
  200000
);

INSERT INTO cliente VALUES (
  14415848,
  '7',
  'MACHUCA',
  'ADONIS',
  'MIGUEL',
  'LOS JAZMINES 1537 DPTO. 41 V.O',
  '22383938',
  '58152298',
  180000
);

INSERT INTO cliente VALUES (
  12241168,
  '8',
  'RAMIREZ',
  'GUTIERREZ',
  'RODRIGO',
  'GUIDO RENNI 4225',
  '25225838',
  '85286676',
  340000
);

INSERT INTO cliente VALUES (
  9798044,
  '9',
  'MALTRAIN',
  'CORTES',
  'JUAN',
  'ENZO PINZA 3330',
  '25554298',
  '95577263',
  260000
);

INSERT INTO cliente VALUES (
  12832359,
  '0',
  'SALAS',
  'TORO',
  'CARLOS',
  'PJE.LLEUQUE 0861 V/EL PERAL 3',
  '22959031',
  '77764463',
  300000
);

INSERT INTO cliente VALUES (
  12302426,
  '1',
  'ALVARADO',
  'ARAUNA',
  'ALEX',
  'PJE.CHONCHI 6678 V/LOS TRONCOS',
  '25230195',
  '67783253',
  1200000
);

INSERT INTO cliente VALUES (
  12859931,
  '2',
  'CESPEDES',
  'LANDEROS',
  'CRISTIAN',
  'BAUTISTA IBARRAL 277',
  '27765868',
  '65296851',
  500000
);

INSERT INTO cliente VALUES (
  12467533,
  '3',
  'HERNANDEZ',
  'DIAZ',
  'JUAN',
  'VARGAS SALCEDO 1541',
  '25332923',
  '55417672',
  320000
);

INSERT INTO cliente VALUES (
  12470801,
  '4',
  'SANCHEZ',
  'RIVERA',
  'JACQUELINE',
  'LUIS INFANTE CERDA 5315',
  '27412764',
  '26399737',
  160000
);

INSERT INTO cliente VALUES (
  13035746,
  '5',
  'LARA',
  'LECAROS',
  'DANIEL',
  'FRANCISCO ESCALONA 3790',
  '26210890',
  '68111801',
  240000
);

INSERT INTO cliente VALUES (
  12866998,
  'K',
  'AVILA',
  'RETAMALES',
  'CRISTIAN',
  'TURMALINA 1495 V/LA SALUD',
  '25457317',
  '78172323',
  260000
);

INSERT INTO cliente VALUES (
  11872936,
  '0',
  'VIDAL',
  'OSSES',
  'LUIS',
  'C.NUEVA IMPERIAL 1045 B/1 DEPTO. 25',
  '25293595',
  '88111254',
  300000
);

INSERT INTO cliente VALUES (
  14526736,
  '1',
  'VALENZUELA',
  'MONTOYA',
  'ROSA',
  'GENARO PRIETO 910 P/EL TRANQUE',
  '28503179',
  '96469095',
  400000
);

INSERT INTO cliente VALUES (
  9964101,
  '2',
  'MENESES',
  'RUBIO',
  'CARLOS',
  'SANTA MARTA 0713',
  '25293285',
  '26438047',
  200000
);

INSERT INTO cliente VALUES (
  12495120,
  '3',
  'RUIZ',
  'BRIONES',
  'CRISTIAN',
  'PJE. FREIRINA 3630',
  '23243232',
  '85289043',
  200000
);

INSERT INTO cliente VALUES (
  13050707,
  '4',
  'VALLE',
  'CASTRIZELO',
  'FREDY',
  'PALERMO P/LA RAZON 2023',
  '27378107',
  '98725363',
  600000
);

INSERT INTO cliente VALUES (
  12415220,
  '5',
  'CASTRO',
  'TOBAR',
  'ALEJANDRA',
  'RODR. DE ARAYA 4651B B/11 DEPTO. 42',
  '22763621',
  '68546237',
  500000
);

INSERT INTO cliente VALUES (
  12459400,
  '6',
  'PICHIHUINCA',
  'JORQUERA',
  'RAFAEL',
  'INGENIERO GIROZ 6035',
  '27783484',
  '72940059',
  250000
);

INSERT INTO cliente VALUES (
  12649413,
  '7',
  'MANZANO',
  'QUINTANILLA',
  'JESSICA',
  'PJE. LAMPA 1391 V/LOS MINERALE',
  '26259699',
  '66213729',
  380000
);

INSERT INTO cliente VALUES (
  12610458,
  '8',
  'BARTLAU',
  'VARGAS',
  'MACARENA',
  'MARIA VIAL 8028',
  '25273848',
  NULL,
  420000
);

INSERT INTO cliente VALUES (
  12364085,
  '9',
  'ARAYA',
  'CAMUS',
  'FREDDY',
  'CARRERA 027',
  '28461589',
  '62514074',
  560000
);

INSERT INTO cliente VALUES (
  12460769,
  'K',
  'DAZA',
  'GUERRERO',
  'ERIC',
  'HERRERA 618',
  '26813742',
  '56215369',
  400000
);

INSERT INTO cliente VALUES (
  13072796,
  '5',
  'MEDINA',
  'CAMUS',
  'WANDA',
  'ICTINOS 1162 VILLA PEDRO LAGOS',
  '22797176',
  '95586941',
  300000
);

INSERT INTO cliente VALUES (
  12649650,
  '6',
  'CUADRA',
  'DISSI',
  'DIEGO',
  'PJE.OLGA DONOSO 4047 P/E.GONEL',
  '26251788',
  NULL,
  200000
);

INSERT INTO cliente VALUES (
  13078214,
  '7',
  'CONCHA',
  'MONTECINOS',
  'KATHERINE',
  'AV. GRECIA 5055 BL/2 DPTO. 22',
  '22724039',
  NULL,
  180000
);

INSERT INTO cliente VALUES (
  12189232,
  '8',
  'DELGADO',
  'GALLEGOS',
  'XIMENA',
  'LUXEMBURGO N�9609',
  '22202264',
  NULL,
  340000
);

INSERT INTO cliente VALUES (
  8533901,
  '9',
  'QUEZADA',
  'VILLENA',
  'CRISTIAN',
  'P. LOS INCAS 1734 V/OLIMPO II',
  '25321876',
  '27344236',
  260000
);

INSERT INTO cliente VALUES (
  12871924,
  '0',
  'VENEGAS',
  'TORRES',
  'JESSICA',
  'GARCIA REYES N�55C',
  '26817651',
  '95596474',
  300000
);

INSERT INTO cliente VALUES (
  13072368,
  '1',
  'JORQUERA',
  'VERA',
  'ALEX',
  'SENDA 12 B/1157 DEPTO. A V/C.18 NOR',
  '22424598',
  NULL,
  1200000
);

INSERT INTO cliente VALUES (
  11226732,
  '2',
  'CAVANELA',
  'ORTEGA',
  'JUAN',
  'PJE BATUCO #9457 V/OHIGGINS',
  '22816328',
  '88582729',
  500000
);

INSERT INTO cliente VALUES (
  11695597,
  '3',
  'BASOALTO',
  'ARANGUIZ',
  'JUAN',
  'SANTA FILOMENA DE NOS',
  '28575175',
  '72850346',
  320000
);

INSERT INTO cliente VALUES (
  13082881,
  '4',
  'FUENTES',
  'FAUNDEZ',
  'FELIPE',
  'GUAYACAN # 063 V/FABERIO',
  '28510780',
  '66228120',
  160000
);

INSERT INTO cliente VALUES (
  14319321,
  '5',
  'SALVO',
  'GUTIERREZ',
  'PATRICIA',
  'PJE # 1 N�675 P/ANTUPILLAN',
  '28587242',
  '57787241',
  240000
);

INSERT INTO cliente VALUES (
  10268208,
  'K',
  'REYES',
  'MORALES',
  'LUIS',
  'BUENOS AIRES #429',
  '28586286',
  '97417379',
  260000
);

INSERT INTO cliente VALUES (
  13050258,
  '0',
  'SALAS',
  'CORNEJO',
  'CARLOS',
  'VALLE DEL SOL N�4028',
  '87418813',
  '25287698',
  300000
);

INSERT INTO cliente VALUES (
  13057574,
  '1',
  'CORNEJO',
  'GONZALEZ',
  'ALEJANDRO',
  'CIENCIAS #8442 P/BIAUT',
  '25586841',
  '72950789',
  400000
);

INSERT INTO cliente VALUES (
  13264443,
  '2',
  'SAN',
  'GARCIA',
  'MARTIN',
  'ALAMEDA #4272 DPTO. 104',
  '27783600',
  '62895758',
  200000
);

INSERT INTO cliente VALUES (
  12861354,
  '3',
  'CADIZ',
  'SANDOVAL',
  'FERNANDO',
  'CALLE LUGO 4671 P.10 PAJARITO',
  '27445878',
  '58214142',
  200000
);

INSERT INTO cliente VALUES (
  12959989,
  '4',
  'JEREZ',
  'CHACON',
  'PAMELA',
  'INES DE SUARES 220',
  '209388532',
  '57813075',
  600000
);

INSERT INTO cliente VALUES (
  12721101,
  '5',
  'JORQUERA',
  'SANCHEZ',
  'LEONEL',
  'ALMIRANTE RIVEROS #9653',
  '25580425',
  '67813075',
  500000
);

INSERT INTO cliente VALUES (
  10711069,
  '6',
  'CISTERNAS',
  'SAAVEDRA',
  'VICTOR',
  'LAGO GRIS 4673 V/EL ALBA',
  '26983708',
  '67813075',
  250000
);

INSERT INTO cliente VALUES (
  12871979,
  '7',
  'RODRIGUEZ',
  'LEMUS',
  'PAOLA',
  'JOAQUIN EDWARDS BELLO #10529',
  '25410073',
  '65428513',
  380000
);

INSERT INTO cliente VALUES (
  10320840,
  '8',
  'DURAN',
  'REBOLLEDO',
  'JAIME',
  'AV.3 PONIENTE 1548 V/VIENA',
  '25327648',
  '77446858',
  420000
);

INSERT INTO cliente VALUES (
  13034352,
  '9',
  'MU�OZ',
  'ASCORRA',
  'CLAUDIA',
  'LOS �ANDUES #509 V/PAJARITOS',
  '22570673',
  NULL,
  560000
);

INSERT INTO cliente VALUES (
  10539484,
  'K',
  'OSORIO',
  'MELLA',
  'JUAN',
  'LO SALINAS 1695',
  '28213010',
  '92796904',
  400000
);

INSERT INTO cliente VALUES (
  12000035,
  '5',
  'ROJAS',
  'ROJAS',
  'MARIO',
  'AV.I.CARRERA PINTO 1041',
  '98112545',
  NULL,
  300000
);

INSERT INTO cliente VALUES (
  7108724,
  '6',
  'QUILODRAN',
  'GARCIA',
  'MARIA',
  'PJE.VARSOVIA 1439 V/ESQUINA B.',
  '25382800',
  '25317903',
  200000
);

INSERT INTO cliente VALUES (
  13083936,
  '7',
  'QUINTANA',
  'MARDONES',
  'RUTH',
  'PASAJE LA RAIZ N�10591',
  '22876325',
  '95281124',
  180000
);

INSERT INTO cliente VALUES (
  12158268,
  '8',
  'ERICES',
  'MOLINA',
  'ELIGIO',
  'PJE.COLORADO 5528 DEPTO. 302',
  '25230176',
  '85283675',
  340000
);

INSERT INTO cliente VALUES (
  12946000,
  '9',
  'CASTILLO',
  'VALENCIA',
  'PAULA',
  'LAS AMAPOLAS 1931 P/PEDRO MONT',
  '26833380',
  '82886471',
  260000
);

INSERT INTO cliente VALUES (
  13085998,
  '0',
  'SUAZO',
  'RIQUELME',
  'OSCAR',
  'PJE.PAULINA 1678 V/BLANCA',
  '25111798',
  '68153576',
  300000
);

INSERT INTO cliente VALUES (
  13032090,
  '1',
  'GONZALEZ',
  'JOFRE',
  'JUAN',
  'PJE.LOS TILOS 8926 P/L.BELTRAN',
  '26446917',
  '55212127',
  1200000
);

INSERT INTO cliente VALUES (
  10293552,
  '2',
  'FRITIS',
  'CHAMBLAS',
  'JOSE',
  'PEDRO AGUIRRE CERDA 5962',
  '26252858',
  '55212127',
  500000
);

INSERT INTO cliente VALUES (
  12960006,
  '3',
  'MARILLANCA',
  'CARVAJAL',
  'ANTONIO',
  'SITIO 37B PINTUE LAGUNA ACULEO',
  '28249080',
  '62562637',
  320000
);

INSERT INTO cliente VALUES (
  10776845,
  '4',
  'NAVARRO',
  'VELASQUEZ',
  'HECTOR',
  'PJE. CAPRI 909 B/5 DEPTO. 103',
  '25577804',
  '56813593',
  160000
);

INSERT INTO cliente VALUES (
  12407575,
  '5',
  'GONZALEZ',
  'LILLO',
  'MARCELA',
  'RODRIGO DE ARAYA 4871 DEPTO. 14',
  '22762321',
  '56812350',
  240000
);

INSERT INTO cliente VALUES (
  14319236,
  'K',
  'ARRIARAN',
  'ROJAS',
  'OSCAR',
  '12 DE FEBRERO 850',
  '28580076',
  '68500893',
  260000
);

INSERT INTO cliente VALUES (
  11339557,
  '0',
  'BUSTOS',
  'MARTINEZ',
  'IVONNE',
  'ALDUNATE 1932',
  '25540604',
  '57762111',
  560000
);

INSERT INTO cliente VALUES (
  11749379,
  '1',
  'MORALES',
  'ZAMORANO',
  'FABIOLA',
  'EL QUETZAL 675',
  '66431810',
  NULL,
  400000
);

INSERT INTO cliente VALUES (
  12270989,
  '2',
  'RAMIREZ',
  'CARDENAS',
  'MAURICIO',
  'CALLE LOS NOGALES 9583',
  '25271068',
  NULL,
  300000
);

INSERT INTO cliente VALUES (
  14254526,
  '3',
  'MARTINEZ',
  'RODRIGUEZ',
  'ERIC',
  'PJE.LAGO RAPEL 1297 V/SENDERO',
  '22919311',
  NULL,
  200000
);

INSERT INTO cliente VALUES (
  12820018,
  '4',
  'ACEVEDO',
  'SANDOVAL',
  'ALEXANDER',
  'LAS CODORNICES 2963-H DPTO. 21',
  '22836901',
  '92894026',
  180000
);

INSERT INTO cliente VALUES (
  12468736,
  '5',
  'GONZALEZ',
  'MU�OZ',
  'OSVALDO',
  'MARIA LUISA BOMBAL 384',
  '27414835',
  '95412144',
  340000
);

INSERT INTO cliente VALUES (
  13088742,
  '6',
  'CID',
  'PADILLA',
  'CAROLINA',
  'AV.FRATERNAL 3910',
  '25225759',
  '88721366',
  260000
);

INSERT INTO cliente VALUES (
  13455413,
  '7',
  'JIMENEZ',
  'PINILLA',
  'CRISTIAN',
  'RICARDO CUMMING 1346 CASA 13',
  '86966329',
  NULL,
  300000
);

INSERT INTO cliente VALUES (
  12685035,
  '8',
  'PEREZ',
  'PINTO',
  'NELSON',
  'EL CARMEN 10364 V/STA.MARIA',
  '22825520',
  '86229671',
  1200000
);

INSERT INTO cliente VALUES (
  11514737,
  '9',
  'MORENO',
  'GONZALEZ',
  'CLAUDIA',
  'GRACIOSA 7815 CERRO NAVIA',
  '26491988',
  NULL,
  500000
);

INSERT INTO cliente VALUES (
  13072851,
  'K',
  'SUAREZ',
  'GONZALEZ',
  'KARINA',
  'PAUL HARRIS 901',
  '22012371',
  NULL,
  320000
);

INSERT INTO cliente VALUES (
  11540908,
  '5',
  'BARRERA',
  'RIOS',
  'LUISA',
  'PASAJE 36 N�4789 V/EYZAGUIRRE',
  '22097186',
  NULL,
  160000
);

INSERT INTO cliente VALUES (
  13269751,
  '6',
  'VALLE',
  'DIAZ',
  'ALEXIS',
  'CUATRO REMOS 580 V/ANT. VARAS',
  '27782342',
  '57788381',
  240000
);

INSERT INTO cliente VALUES (
  12684459,
  '7',
  'CARVAJAL',
  'REYES',
  'PABLO',
  'VICTORIA 615',
  '25558281',
  '67415270',
  260000
);

INSERT INTO cliente VALUES (
  9969366,
  '8',
  'FUENTES',
  'CORTES',
  'LUIS',
  'IGNACIO CARRERA PINTO 6013',
  '26232094',
  '57719055',
  600000
);

INSERT INTO cliente VALUES (
  10917199,
  '9',
  'ACU�A',
  'OLIVARES',
  'ELIZABETH',
  'CERRO HUEMUL 1052',
  '57736141',
  NULL,
  500000
);

INSERT INTO cliente VALUES (
  13098962,
  '0',
  'SANTA',
  'DIAZ',
  'MARIA',
  'AV.KENNEDY B/16 DEPTO. 31 P/MANSO',
  '2253899',
  '76814737',
  250000
);

INSERT INTO cliente VALUES (
  12672729,
  '1',
  'BARRAZA',
  'LOBOS',
  'EDUARDO',
  'TRICAO 460 P/ EUGENIPO MATTE',
  '28512060',
  '77735367',
  380000
);

INSERT INTO cliente VALUES (
  13041711,
  '2',
  'ITURRIETA',
  'GONZALEZ',
  'PABLO',
  'AV. TRANSITO 5291',
  '27753384',
  '67356222',
  420000
);

INSERT INTO propietario VALUES (
  12491094,
  '3',
  'SAAVEDRA',
  'VILLALOBOS',
  'SERGIO',
  'VIA 7 N�1000 B/3 D/7',
  '22398244',
  NULL
);

INSERT INTO propietario VALUES (
  12651346,
  '4',
  'MU�OZ',
  'PEREZ',
  'CLAUDIA',
  'SANTA ISABEL 463',
  '26359178',
  '27412904'
);

INSERT INTO propietario VALUES (
  12116380,
  '5',
  'BARAHONA',
  'ORELLANA',
  'JOSE',
  'NTRA. SRA. SANTA GENOVEVA 9508',
  '22871051',
  NULL
);

INSERT INTO propietario VALUES (
  13024901,
  'K',
  'VALENCIA',
  'URBINA',
  'SERGIO',
  'MARIA ELENA 1857 V/LOS NAVIOS',
  '25417284',
  '26211095'
);

INSERT INTO propietario VALUES (
  12885975,
  '0',
  'BARRIOS',
  'MU�OZ',
  'BARBARA',
  'PASAJE PUCON 5940',
  '22215104',
  '26710430'
);

INSERT INTO propietario VALUES (
  13041308,
  '1',
  'PARDO',
  'ESPINOSA',
  'RICHARD',
  'PJE.PIRAMIDE 1477 P/BOROA',
  '26811939',
  '27740990'
);

INSERT INTO propietario VALUES (
  11947288,
  '2',
  'QUEZADA',
  'GOMEZ',
  'MARIO',
  'LAS MALVAS 10470 V/PENSAMIENTO',
  '2R 5415191',
  '25410480'
);

INSERT INTO propietario VALUES (
  12783347,
  '3',
  'CUBILLOS',
  'FERRADA',
  'JORGE',
  'LAGO RUPANCO 1556 P/LANALHUE',
  '22930493',
  '25377732'
);

INSERT INTO propietario VALUES (
  13195197,
  '4',
  'GUERRERO',
  'ROMO',
  'MAURICIO',
  'BROCKMAN 1326 VILLA ITALIA',
  '2232366',
  '28113377'
);

INSERT INTO propietario VALUES (
  12676073,
  '5',
  'PIZARRO',
  'TORO',
  'JAIME',
  'FCO.BILBAO 1826 P/SAN RAFAEL',
  '25426807',
  NULL
);

INSERT INTO propietario VALUES (
  13471056,
  '6',
  'MIRANDA',
  'VALENZUELA',
  'PRISCILLA',
  'AV. COLECTOR 4866 P/SANTIAGO',
  '27796916',
  '27790195'
);

INSERT INTO propietario VALUES (
  12064147,
  '7',
  'ROBLES',
  'VIDAL',
  'LUIS',
  'SEGUNDA TRANSVERSAL PJ.2 C/996',
  '25573796',
  '25268570'
);

INSERT INTO propietario VALUES (
  14149786,
  '8',
  'ROBLES',
  'CAMIRUAGA',
  'AQUILES',
  'DIAGONAL PARAGUAY 360 DPTO 116',
  '22227933',
  '25325139'
);

INSERT INTO propietario VALUES (
  13071695,
  '9',
  'LOSADA',
  'MALDONADO',
  'LEONARDO',
  'OCTAVA AV.PJE.JOSE READY 6256',
  '25222006',
  '25311153'
);

INSERT INTO propietario VALUES (
  12870395,
  'K',
  'HERNANDEZ',
  'VALLADARES',
  'JONATHA',
  'PJE.RENE OLIVARES 1294',
  '25389883',
  '26413331'
);

INSERT INTO propietario VALUES (
  14412994,
  '5',
  'ALARCON',
  'QUIROGA',
  'JOHN',
  'CALLE 1 C/4452 P/SANTIAGO',
  '27789352',
  '25261372'
);

INSERT INTO propietario VALUES (
  12878526,
  '6',
  'RIQUELME',
  'CORREA',
  'JOHN',
  'MOISES RIOS N�1065',
  '27375662',
  '25261372'
);

INSERT INTO propiedad VALUES (
  1001,
  'Serrano #275',
  180,
  6,
  2,
  1250000,
  NULL,
  'A',
  80,
  12491094,
  12811094
);

INSERT INTO propiedad VALUES (
  1002,
  'Luis Matte #1477',
  81,
  4,
  1,
  240000,
  40000,
  'B',
  81,
  12491094,
  12113369
);

INSERT INTO propiedad VALUES (
  1003,
  'Vic. Mackenna 945',
  62,
  4,
  2,
  350000,
  70000,
  'A',
  82,
  12651346,
  12456905
);

INSERT INTO propiedad VALUES (
  1004,
  'Celerino Pereira 1567',
  73,
  3,
  1,
  375000,
  40000,
  'A',
  83,
  12116380,
  12466553
);

INSERT INTO propiedad VALUES (
  1005,
  'Vicuna Mackena 285',
  62,
  3,
  2,
  600000,
  50000,
  'B',
  84,
  12885975,
  11745244
);

INSERT INTO propiedad VALUES (
  1006,
  'Pardo 1288',
  51,
  NULL,
  NULL,
  145000,
  30000,
  'C',
  85,
  12885975,
  12811094
);

INSERT INTO propiedad VALUES (
  1007,
  'Pje. Patria Vieja 7272',
  52,
  2,
  2,
  165000,
  NULL,
  'A',
  81,
  13041308,
  12888868
);

INSERT INTO propiedad VALUES (
  1008,
  'Jose Maria Caro 2551',
  52,
  2,
  1,
  220000,
  25000,
  'B',
  82,
  11947288,
  12811094
);

INSERT INTO propiedad VALUES (
  1009,
  'Galvarino 627',
  73,
  3,
  2,
  300000,
  NULL,
  'A',
  83,
  12783347,
  12811094
);

INSERT INTO propiedad VALUES (
  1010,
  'Pje. Piave 1439',
  72,
  3,
  1,
  450000,
  60000,
  'B',
  82,
  13195197,
  11630572
);

INSERT INTO propiedad VALUES (
  1011,
  'Las Carretas 2089',
  64,
  4,
  2,
  700000,
  35000,
  'E',
  122,
  12676073,
  12642309
);

INSERT INTO propiedad VALUES (
  1012,
  'Donatello 7421 D. 107',
  62,
  3,
  1,
  320000,
  46000,
  'B',
  82,
  12676073,
  12113369
);

INSERT INTO propiedad VALUES (
  1013,
  'Totoralillo 1514',
  63,
  NULL,
  NULL,
  175000,
  NULL,
  'C',
  81,
  13471056,
  12456905
);

INSERT INTO propiedad VALUES (
  1014,
  'Tres Oriente N�6543',
  62,
  3,
  1,
  260000,
  NULL,
  'A',
  80,
  12064147,
  12466553
);

INSERT INTO propiedad VALUES (
  1015,
  'Pablo Burchard 566 Depto. 1002',
  41,
  2,
  2,
  280000,
  35000,
  'B',
  82,
  14149786,
  11745244
);

INSERT INTO propiedad VALUES (
  1016,
  'Pje. Caboz 2 Pedro Nu�ez 5879',
  45,
  2,
  1,
  160000,
  25000,
  'B',
  83,
  13071695,
  11630572
);

INSERT INTO propiedad VALUES (
  1017,
  'Domeyko 2109',
  62,
  3,
  2,
  600000,
  90000,
  'B',
  84,
  12870395,
  12466553
);

INSERT INTO propiedad VALUES (
  1018,
  'Abdon Cifuentes 61',
  63,
  3,
  1,
  1700000,
  120000,
  'E',
  126,
  12870395,
  12466553
);

INSERT INTO propiedad VALUES (
  1019,
  'Club Hipico 473 Depto. 706',
  66,
  3,
  2,
  320000,
  NULL,
  'A',
  86,
  12870395,
  12456905
);

INSERT INTO propiedad VALUES (
  1020,
  'San Pablo 6828 Depto. 201 BlocK. 5',
  74,
  3,
  1,
  342000,
  49000,
  'B',
  87,
  13071695,
  11745244
);

INSERT INTO propiedad VALUES (
  1021,
  'Sevilla N�1782',
  52,
  2,
  2,
  250000,
  50000,
  'B',
  81,
  14412994,
  11745244
);

INSERT INTO propiedad VALUES (
  1022,
  'Emiliano Figueroa 9221',
  53,
  2,
  1,
  820000,
  160000,
  'B',
  82,
  14412994,
  12888868
);

INSERT INTO propiedad VALUES (
  1023,
  'Las Acacias S/N',
  78,
  4,
  1,
  800000,
  NULL,
  'A',
  82,
  12878526,
  12642309
);

INSERT INTO propiedad VALUES (
  1024,
  'Los Duraznos 89',
  70,
  3,
  1,
  750000,
  NULL,
  'A',
  82,
  12878526,
  12642309
);

INSERT INTO propiedad VALUES (
  1025,
  'Totoral S/N',
  66,
  NULL,
  NULL,
  1300000,
  40000,
  'D',
  123,
  12878526,
  11630572
);

INSERT INTO propiedad VALUES (
  1026,
  'Bandera 458',
  34,
  NULL,
  2,
  300000,
  NULL,
  'C',
  82,
  12878526,
  11630572
);

INSERT INTO arriendo_propiedad VALUES(1003,12467572,TO_DATE('14/10/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-15)),TO_DATE('20/03/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-7)));
INSERT INTO arriendo_propiedad VALUES(1003,10639521,TO_DATE('05/05/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-8)),NULL);
INSERT INTO arriendo_propiedad VALUES(1019,12467572,TO_DATE('01/01/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-8)),NULL);
INSERT INTO arriendo_propiedad VALUES(1009,13463138,TO_DATE('05/03/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-8)),TO_DATE('31/12/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-7)));
INSERT INTO arriendo_propiedad VALUES(1004,12817700,
TO_DATE('02/04/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-9)), NULL);

INSERT INTO arriendo_propiedad VALUES (
  1007,
  11996940,
TO_DATE('13/05/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-9)),
  NULL
);

INSERT INTO arriendo_propiedad VALUES (
  1001,
  8716085,
TO_DATE('01/05/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-9)),
TO_DATE('30/04/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-7))
);

INSERT INTO arriendo_propiedad VALUES (
  1024,
  9771046,
TO_DATE('05/05/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-10)),
  NULL
);

INSERT INTO arriendo_propiedad VALUES (
  1016,
  14148957,
TO_DATE('20/05/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-9)),
  NULL
);

INSERT INTO arriendo_propiedad VALUES (
  1017,
  11976208,
TO_DATE('02/03/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-8)),
TO_DATE('30/12/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-6))
);

INSERT INTO arriendo_propiedad VALUES (
  1010,
  13072743,
TO_DATE('03/03/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-10)),
TO_DATE('08/12/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-8))
);

INSERT INTO arriendo_propiedad VALUES (
  1010,
  16960649,
TO_DATE('03/03/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-8)),
  NULL
);

INSERT INTO arriendo_propiedad VALUES (
  1012,
  11635470,
TO_DATE('18/04/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-8)),
  NULL
);

INSERT INTO arriendo_propiedad VALUES (
  1008,
  9798044,
TO_DATE('05/02/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-8)),
  NULL
);

INSERT INTO arriendo_propiedad VALUES (
  1013,
  11872936,
TO_DATE('05/02/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-8)),
  NULL
);

INSERT INTO arriendo_propiedad VALUES (
  1006,
  12649413,
TO_DATE('20/01/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-10)),
TO_DATE('31/12/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-5))
);

INSERT INTO arriendo_propiedad VALUES (
  1026,
  8533901,
TO_DATE('13/01/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-11)),
  NULL
);

INSERT INTO arriendo_propiedad VALUES (
  1011,
  11695597,
TO_DATE('02/01/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-8)),
  NULL
);

INSERT INTO arriendo_propiedad VALUES (
  1018,
  13050258,
TO_DATE('17/03/' || TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-8)),
  NULL
);

INSERT INTO comision VALUES (
  1,
  1,
  2,
  100000
);

INSERT INTO comision VALUES (
  2,
  3,
  4,
  250000
);

INSERT INTO comision VALUES (
  3,
  5,
  6,
  350000
);

INSERT INTO comision VALUES (
  4,
  7,
  10,
  450000
);

INSERT INTO comision VALUES (
  5,
  11,
  20,
  600000
);

INSERT INTO comision VALUES (
  6,
  21,
  99,
  800000
);

COMMIT;








SELECT * FROM CLIENTE;



-- CASO 1: Informe de clientes por rango de renta

SELECT
    /* Formato de RUT con puntos y guion */
    REGEXP_REPLACE(
        TO_CHAR(c.numrut_cli),
        '(\d)(?=(\d{3})+(?!\d))',
        '\1.'
    ) || '-' || c.dvrut_cli AS RUT_FORMATO,

    /* Nombre completo */
    c.nombre_cli || ' ' || c.appaterno_cli || ' ' || c.apmaterno_cli AS NOMBRE_COMPLETO,

    /* Renta */
    c.renta_cli AS RENTA,

    /* Clasificación por tramos */
    CASE 
        WHEN c.renta_cli > 500000 THEN 'TRAMO 1'
        WHEN c.renta_cli BETWEEN 400000 AND 500000 THEN 'TRAMO 2'
        WHEN c.renta_cli BETWEEN 200000 AND 399999 THEN 'TRAMO 3'
        ELSE 'TRAMO 4'
    END AS TRAMO

FROM cliente c
WHERE c.renta_cli BETWEEN &RENTA_MINIMA AND &RENTA_MAXIMA
  AND c.celular_cli IS NOT NULL
ORDER BY NOMBRE_COMPLETO ASC;
     
-- CASO 2: Sueldo promedio por categoría y sucursal

--  Requisitos cumplidos:
--  Agrupación por categoría y sucursal
--  Sueldo promedio con formato CLP
--  Clasificación por códigos
--  Filtra por sueldo promedio mínimo
--  Ordena por sueldo promedio DESC


SELECT
    ce.desc_categoria_emp AS CATEGORIA,
    s.desc_sucursal AS SUCURSAL,

    TO_CHAR(AVG(e.sueldo_emp), 'L999G999G999') AS SUELDO_PROMEDIO

FROM empleado e
JOIN categoria_empleado ce
    ON e.id_categoria_emp = ce.id_categoria_emp
JOIN sucursal s
    ON e.id_sucursal = s.id_sucursal

GROUP BY ce.desc_categoria_emp, s.desc_sucursal
HAVING AVG(e.sueldo_emp) > &SUELDO_PROMEDIO_MINIMO
ORDER BY AVG(e.sueldo_emp) DESC;
  
  
  -- CASO 3: Arriendo promedio por tipo de propiedad

SELECT
    tp.desc_tipo_propiedad AS TIPO_PROPIEDAD,

    COUNT(*) AS TOTAL_PROPIEDADES,

    AVG(p.valor_arriendo) AS PROM_ARRIENDO,
    AVG(p.superficie) AS PROM_SUPERFICIE,

    AVG(p.valor_arriendo / p.superficie) AS ARRIENDO_M2,

    CASE
        WHEN AVG(p.valor_arriendo / p.superficie) < 5000 THEN 'ECONOMICO'
        WHEN AVG(p.valor_arriendo / p.superficie) BETWEEN 5000 AND 10000 THEN 'MEDIO'
        ELSE 'ALTO'
    END AS CLASIFICACION

FROM propiedad p
JOIN tipo_propiedad tp
    ON p.id_tipo_propiedad = tp.id_tipo_propiedad

GROUP BY tp.desc_tipo_propiedad
HAVING AVG(p.valor_arriendo / p.superficie) > 1000
ORDER BY ARRIENDO_M2 DESC;