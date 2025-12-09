ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/RRRR';

-- Borrado de objetos

DROP TABLE bono_escolar CASCADE CONSTRAINTS;
DROP TABLE trabajador CASCADE CONSTRAINTS;
DROP TABLE asignacion_familiar CASCADE CONSTRAINTS;
DROP TABLE tickets_concierto CASCADE CONSTRAINTS;
DROP TABLE comisiones_ticket CASCADE CONSTRAINTS;
DROP TABLE bono_antiguedad CASCADE CONSTRAINTS;
DROP TABLE isapre CASCADE CONSTRAINTS;
DROP TABLE afp CASCADE CONSTRAINTS;
DROP TABLE comuna_ciudad CASCADE CONSTRAINTS;
DROP TABLE tipo_trabajador CASCADE CONSTRAINTS;
DROP TABLE estado_civil CASCADE CONSTRAINTS;
DROP TABLE est_civil CASCADE CONSTRAINTS;
DROP TABLE detalle_bonificaciones_trabajador CASCADE CONSTRAINTS;
DROP SEQUENCE seq_det_bonif;
DROP SEQUENCE seq_cat;
DROP SEQUENCE seq_com;
DROP SEQUENCE seq_porc_com_annos;

-- Creaci�n de objetos

CREATE SEQUENCE seq_cat;

CREATE SEQUENCE seq_com START WITH 80;

CREATE SEQUENCE seq_porc_com_annos;

CREATE SEQUENCE seq_det_bonif START WITH 100 INCREMENT BY 10;

CREATE TABLE afp (
    cod_afp         NUMBER(2)
        CONSTRAINT pk_afp PRIMARY KEY,
    nombre_afp      VARCHAR2(30) NOT NULL,
    porc_descto_afp NUMBER(2) NOT NULL
);

CREATE TABLE isapre (
    cod_isapre         NUMBER(2)
        CONSTRAINT pk_isapre PRIMARY KEY,
    nombre_isapre      VARCHAR2(30) NOT NULL,
    porc_descto_isapre NUMBER(2) NOT NULL
);

CREATE TABLE comuna_ciudad (
    id_ciudad     NUMBER(3) NOT NULL,
    nombre_ciudad VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_ciudad PRIMARY KEY ( id_ciudad )
);

CREATE TABLE tipo_trabajador (
    id_categoria   NUMBER(1) NOT NULL,
    desc_categoria VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_tipo_trab PRIMARY KEY ( id_categoria )
);

CREATE TABLE estado_civil (
    id_estcivil   NUMBER(1) NOT NULL,
    desc_estcivil VARCHAR2(25) NOT NULL,
    CONSTRAINT pk_estado_civil_ PRIMARY KEY ( id_estcivil )
);

CREATE TABLE bono_escolar (
    id_escolar NUMBER(2) NOT NULL,
    sigla      VARCHAR2(6) NOT NULL,
    descrip    VARCHAR2(50) NOT NULL,
    porc_bono  NUMBER(2),
    CONSTRAINT pk_escolaridad PRIMARY KEY ( id_escolar )
);

CREATE TABLE trabajador (
    numrut           NUMBER(10) NOT NULL,
    dvrut            VARCHAR2(1) NOT NULL,
    appaterno        VARCHAR2(20) NOT NULL,
    apmaterno        VARCHAR2(20) NOT NULL,
    nombre           VARCHAR2(25) NOT NULL,
    direccion        VARCHAR2(35) NOT NULL,
    fonofijo         VARCHAR2(15) NOT NULL,
    fecnac           DATE,
    fecing           DATE NOT NULL,
    sueldo_base      NUMBER(7) NOT NULL,
    id_ciudad        NUMBER(3),
    id_categoria_t   NUMBER(1),
    id_escolaridad_t NUMBER(2) NOT NULL,
    cod_afp          NUMBER(2) NOT NULL,
    cod_isapre       NUMBER(2) NOT NULL,
    CONSTRAINT pk_trabajador PRIMARY KEY ( numrut ),
    CONSTRAINT fk_trabajador_ciudad FOREIGN KEY ( id_ciudad )
        REFERENCES comuna_ciudad ( id_ciudad ),
    CONSTRAINT fk_trabajador_afp FOREIGN KEY ( cod_afp )
        REFERENCES afp ( cod_afp ),
    CONSTRAINT fk_trabajador_isapre FOREIGN KEY ( cod_isapre )
        REFERENCES isapre ( cod_isapre ),
    CONSTRAINT fk_trabajador_escolaridad FOREIGN KEY ( id_escolaridad_t )
        REFERENCES bono_escolar ( id_escolar ),
    CONSTRAINT fk_trabajador_tipo_t FOREIGN KEY ( id_categoria_t )
        REFERENCES tipo_trabajador ( id_categoria )
);

CREATE TABLE asignacion_familiar (
    numrut_carga    NUMBER(10) NOT NULL
        CONSTRAINT pk_asg_familiar PRIMARY KEY,
    dvrut_carga     VARCHAR2(1) NOT NULL,
    appaterno_carga VARCHAR2(15) NOT NULL,
    apmaterno_carga VARCHAR2(15) NOT NULL,
    nombre_carga    VARCHAR2(25) NOT NULL,
    numrut_t        NUMBER(10) NOT NULL,
    CONSTRAINT fk_asgn_familiar_t FOREIGN KEY ( numrut_t )
        REFERENCES trabajador ( numrut )
);

CREATE TABLE detalle_bonificaciones_trabajador (
    num                   NUMBER(10)
        CONSTRAINT pk_det_bont PRIMARY KEY,
    rut                   VARCHAR2(20),
    nombre_trabajador     VARCHAR2(70),
    sueldo_base           VARCHAR2(15) NOT NULL,
    num_ticket            VARCHAR2(12) NOT NULL,
    direccion             VARCHAR2(50) NOT NULL,
    sistema_salud         VARCHAR2(30) NOT NULL,
    monto                 VARCHAR2(15) NOT NULL,
    bonif_x_ticket        VARCHAR2(15) NOT NULL,
    simulacion_x_ticket   VARCHAR2(15) NOT NULL,
    simulacion_antiguedad VARCHAR2(15) NOT NULL
);

CREATE TABLE tickets_concierto (
    nro_ticket   NUMBER(10) PRIMARY KEY,
    fecha_ticket DATE NOT NULL,
    monto_ticket NUMBER(15) NOT NULL,
    id_cliente   NUMBER(10) NOT NULL,
    numrut_t     NUMBER(10) NOT NULL,
    CONSTRAINT fk_ftrabajador FOREIGN KEY ( numrut_t )
        REFERENCES trabajador ( numrut )
);

CREATE TABLE bono_antiguedad (
    id              NUMBER(2)
        CONSTRAINT pk_annos_trabajados PRIMARY KEY,
    limite_inferior NUMBER(2) NOT NULL,
    limite_superior NUMBER(2) NOT NULL,
    porcentaje      NUMBER(3, 2) NOT NULL
);

CREATE TABLE comisiones_ticket (
    nro_ticket     NUMBER(10) NOT NULL PRIMARY KEY,
    valor_comision NUMBER(10) NOT NULL,
    CONSTRAINT fk_vta_ticket FOREIGN KEY ( nro_ticket )
        REFERENCES tickets_concierto ( nro_ticket )
);

CREATE TABLE est_civil (
    numrut_t        NUMBER(10) NOT NULL,
    id_estcivil_est NUMBER(1) NOT NULL,
    fecini_estcivil DATE NOT NULL,
    fecter_estcivil DATE,
    CONSTRAINT pk_est_civil PRIMARY KEY ( numrut_t,
                                          id_estcivil_est ),
    CONSTRAINT fk_est_civil_trab FOREIGN KEY ( numrut_t )
        REFERENCES trabajador ( numrut ),
    CONSTRAINT fk_civil_estciv FOREIGN KEY ( id_estcivil_est )
        REFERENCES estado_civil ( id_estcivil )
);



-- insercion de datos

INSERT INTO AFP VALUES(1,'MODELO',9);
INSERT INTO AFP VALUES(2,'PLANVITAL',15);
INSERT INTO AFP VALUES(3,'CAPITAL',11);
INSERT INTO AFP VALUES(4,'CUPRUM',12);
INSERT INTO AFP VALUES(5,'PROVIDA',11);
INSERT INTO AFP VALUES(6,'HABITAT',15);

INSERT INTO ISAPRE VALUES(1,'FONASA',5);
INSERT INTO ISAPRE VALUES(2,'BANMEDICA',10);
INSERT INTO ISAPRE VALUES(3,'COLMENA',8);
INSERT INTO ISAPRE VALUES(4,'FUNDACION',12);
INSERT INTO ISAPRE VALUES(5,'CRUZ BLANCA',12);
INSERT INTO ISAPRE VALUES(6,'MAS VIDA',6);
INSERT INTO ISAPRE VALUES(7,'VIDA TRES',11);

INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Las Condes');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Providencia');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Santiago');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Nunoa');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Vitacura');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'La Reina');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'La Florida');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Maipu');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Lo Barnechea');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Macul');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'San Miguel');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Penalolen');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Puente Alto');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Recoleta');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Estacion Central');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'San Bernardo');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Independencia');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'La Cisterna');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Quilicura');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Quinta Normal');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Conchali');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'San Joaquin');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Huechuraba');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'El Bosque');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Cerrillos');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Cerro Navia');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'La Granja');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'La Pintana');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Lo Espejo');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Lo Prado');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Pedro Aguirre Cerda');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Pudahuel');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Renca');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'San Ramon');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Melipilla');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'San Pedro');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Alhue');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Maria Pinto');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Curacavi');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Talagante');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'El Monte');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Buin');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Paine');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Penaflor');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Isla de Maipo');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Colina');
INSERT INTO COMUNA_CIUDAD VALUES (seq_com.NEXTVAL,'Pirque');

INSERT INTO TIPO_TRABAJADOR VALUES (seq_cat.NEXTVAL,'VENDEDOR HONORARIOS');
INSERT INTO TIPO_TRABAJADOR VALUES (seq_cat.NEXTVAL,'PLANTA');
INSERT INTO TIPO_TRABAJADOR VALUES (seq_cat.NEXTVAL,'CAJERO');
INSERT INTO TIPO_TRABAJADOR VALUES (seq_cat.NEXTVAL,'CONTRATO PLAZO FIJO');

INSERT INTO estado_civil VALUES(1,'Soltero');
INSERT INTO estado_civil VALUES(2,'Casado');
INSERT INTO estado_civil VALUES(3,'Separado');
INSERT INTO estado_civil VALUES(4,'Divorciado');
INSERT INTO estado_civil VALUES(5,'Viudo');

INSERT INTO BONO_ESCOLAR VALUES(10,'BA','BASICA',1);
INSERT INTO BONO_ESCOLAR VALUES(20,'MCH','MEDIA CIENTIFICA HUMANISTA',2);
INSERT INTO BONO_ESCOLAR VALUES(30,'MTP','MEDIA TECNICO PROFESIONAL',3);
INSERT INTO BONO_ESCOLAR VALUES(40,'SCFT','SUPERIOR CENTRO DE FORMACION TECNICA',4);
INSERT INTO BONO_ESCOLAR VALUES(50,'SIP','SUPERIOR INSTITUTO PROFESIONAL',5);
INSERT INTO BONO_ESCOLAR VALUES(60,'SUO','SUPERIOR UNIVERSIDAD',6);

INSERT INTO TRABAJADOR VALUES (11649964,'0','GALVEZ','CASTRO','MARTA','CLOVIS MONTERO 0260 D/202','23417556','20121971','01071996',1515239,80,1,10,1,1);
INSERT INTO TRABAJADOR VALUES (12113369,'4','ROMERO','DIAZ','NANCY','TENIENTE RAMON JIMENEZ 4753','25631567','09011968','01081991',2710153,81,3,20,2,1);
INSERT INTO TRABAJADOR VALUES (12456905,'1','CANALES','BASTIAS','JORGE','GENERAL CONCHA PEDREGAL #885','27413395','21121957','01091983',2945675,81,3,20,2,1);
INSERT INTO TRABAJADOR VALUES (12466553,'2','VIDAL','PEREZ','TERESA','FCO. DE CAMARGO 14515 D/14','28122603','01081996','01081994',1202614,82,3,10,3,7);
INSERT INTO TRABAJADOR VALUES (11745244,'3','VENEGAS','SOTO','KARINA','ARICA 3850','27494190','01081988','01081994',1439042,83,3,60,4,7);
INSERT INTO TRABAJADOR VALUES (11999100,'4','CONTRERAS','CASTILLO','CLAUDIO','ISABEL RIQUELME 6075','27764142','24121966','01081994',364163,84,4,30,6,6);
INSERT INTO TRABAJADOR VALUES (12888868,'5','PAEZ','MACMILLAN','JOSE','FERNANDEZ CONCHA 500','22399493','25121964','01031991',1896155,85,3,30,5,7);
INSERT INTO TRABAJADOR VALUES (12811094,'6','MOLINA','GONZALEZ','PAULA','PJE.TIMBAL 1095 V/POMAIRE','25313830','26121978','01042017',1757577,86,3,60,3,5);
INSERT INTO TRABAJADOR VALUES (14255602,'7','MUNOZ','ROJAS','CARLOTA','TERCEIRA 7426 V/LIBERTAD','26490093','01052006','01081994',2658577,87,2,50,4,4);
INSERT INTO TRABAJADOR VALUES (11630572,'8','ARAVENA','HERBAGE','GUSTAVO','FERNANDO DE ARAGON 8420','25588481',NULL,'01072001',1957095,88,3,40,1,1);
INSERT INTO TRABAJADOR VALUES (11636534,'9','ADASME','ZUNIGA','LUIS','LITTLE ROCK 117 V/PDTE.KENNEDY','26483081','29121973','01061996',1614934,89,3,50,6,7);
INSERT INTO TRABAJADOR VALUES (12272880,'K','LAPAZ','SEPULVEDA','MARCO','GUARDIA MARINA. RIQUELME 561','26038967','30121989','01072016',1352596,92,3,40,5,1);
INSERT INTO TRABAJADOR VALUES (11846972,'5','OGAZ','VARAS','MARCO','OVALLE N�5798 V/ OHIGGINS','27763209','31121959','01022017',253590,94,4,50,6,4);
INSERT INTO TRABAJADOR VALUES (14283083,'6','MONDACA','COLLAO','AUGUSTO','NUEVA COLON N�1152','27357104','01011989','01092013',1144245,95,2,50,3,6);
INSERT INTO TRABAJADOR VALUES (14541837,'7','ALVAREZ','RIVERA','MARCO','HONDURAS B/8908 D/102 L.BRISAS','22875902','02011977','01101996',1541418,97,3,20,4,7);
INSERT INTO TRABAJADOR VALUES (12482036,'8','OLAVE','CASTILLO','ADRIAN','ELISA CORREA 188','22888897','03011956','01111986',1068086,98,3,20,1,1);
INSERT INTO TRABAJADOR VALUES (12468081,'9','SANCHEZ','GONZALEZ','PAOLA','AV.OSSA 01240 V/MI VInITA','25273328','04011987','01082012',1330355,99,3,60,4,1);
INSERT INTO TRABAJADOR VALUES (12260812,'0','RIOS','ZUNIGA','RAFAEL','LOS CASTAnOS 1427 VILLA C.C.U.','26410462','05011991','01032013',367056,106,4,50,4,3);
INSERT INTO TRABAJADOR VALUES (12899759,'1','CACERES','JIMENEZ','ERIKA','PJE.NAVARINO 15758 V/P.DE OnA','28593881','06011974','01121994',2281415,107,3,40,4,5);
INSERT INTO TRABAJADOR VALUES (12868553,'2','CHACON','AMAYA','PATRICIA','LO ERRAZURIZ 530 V/EL SENDERO','25577963','07011985','01012006',1723055,108,3,10,1,2);
INSERT INTO TRABAJADOR VALUES (12648200,'3','NARVAEZ','MUNOZ','LUIS','AMBRIOSO OHIGGINS  2010','27742268','08011993','01032017',1966613,80,3,60,2,1);
INSERT INTO TRABAJADOR VALUES (11670042,'5','GONGORA','DEVIA','VALESKA','PASAJE VENUS 2765','23244270','10011975','01091998',1635086,82,3,30,1,1);
INSERT INTO TRABAJADOR VALUES (12642309,'K','NAVARRO','SANTIBANEZ','JUAN','SANTA ELENA 300 V/LOS ALAMOS','25342599','11011986','02092011',1659230,83,3,30,6,7);

INSERT INTO EST_CIVIL VALUES (11649964,1,'01071996','31052016');
INSERT INTO EST_CIVIL VALUES (11649964,2,'01062016',NULL);
INSERT INTO EST_CIVIL VALUES (12113369,4,'01081991','05062018');
INSERT INTO EST_CIVIL VALUES (12113369,2,'06062018',NULL);
INSERT INTO EST_CIVIL VALUES (12456905,2,'01091983',NULL);
INSERT INTO EST_CIVIL VALUES (12466553,3,'01081996',NULL);
INSERT INTO EST_CIVIL VALUES (11745244,1,'01081988',NULL);
INSERT INTO EST_CIVIL VALUES (11999100,2,'01081994',NULL);
INSERT INTO EST_CIVIL VALUES (12888868,3,'01031991',NULL);
INSERT INTO EST_CIVIL VALUES (12811094,4,'01042018',NULL);
INSERT INTO EST_CIVIL VALUES (14255602,1,'01052006',NULL);
INSERT INTO EST_CIVIL VALUES (11630572,3,'01072001',NULL);
INSERT INTO EST_CIVIL VALUES (11636534,1,'01061996','02062018');
INSERT INTO EST_CIVIL VALUES (11636534,2,'03062018',NULL);
INSERT INTO EST_CIVIL VALUES (12272880,2,'01072016',NULL);
INSERT INTO EST_CIVIL VALUES (11846972,3,'01042018',NULL);
INSERT INTO EST_CIVIL VALUES (14283083,4,'01092013',NULL);
INSERT INTO EST_CIVIL VALUES (14541837,1,'01101996','15062018');
INSERT INTO EST_CIVIL VALUES (14541837,2,'16062018',NULL);
INSERT INTO EST_CIVIL VALUES (12482036,2,'01111986',NULL);
INSERT INTO EST_CIVIL VALUES (12468081,3,'01082012',NULL);
INSERT INTO EST_CIVIL VALUES (12260812,4,'01032013',NULL);
INSERT INTO EST_CIVIL VALUES (12899759,1,'01121994',NULL);
INSERT INTO EST_CIVIL VALUES (12868553,2,'01012006',NULL);
INSERT INTO EST_CIVIL VALUES (12648200,3,'01032017',NULL);
INSERT INTO EST_CIVIL VALUES (11670042,1,'01091998','06062018');
INSERT INTO EST_CIVIL VALUES (11670042,2,'07062018',NULL);
INSERT INTO EST_CIVIL VALUES (12642309,2,'02092011',NULL);

INSERT INTO ASIGNACION_FAMILIAR VALUES(20639521,'0','ARAVENA','RIQUELME','Jorge',11630572);
INSERT INTO ASIGNACION_FAMILIAR VALUES(19074837,'1','ARAVENA','RIQUELME','CESAR',11630572);
INSERT INTO ASIGNACION_FAMILIAR VALUES(22251882,'2','ARAVENA','DONOSO','CLAUDIO',11630572);
INSERT INTO ASIGNACION_FAMILIAR VALUES(17238830,'3','RIOS','CAVERO','Pedro',12260812);
INSERT INTO ASIGNACION_FAMILIAR VALUES(18777063,'4','RIOS','CAVERO','PABLO',12260812);
INSERT INTO ASIGNACION_FAMILIAR VALUES(22467572,'5','TRONCOSO','ROMERO','CLAUDIO',12113369);
INSERT INTO ASIGNACION_FAMILIAR VALUES(20487147,'9','SOTO','MUNOZ','MARTINA',14255602);

INSERT INTO BONO_ANTIGUEDAD VALUES(seq_porc_com_annos.NEXTVAL,2,8,0.05);
INSERT INTO BONO_ANTIGUEDAD VALUES(seq_porc_com_annos.NEXTVAL,10,15,0.06);
INSERT INTO BONO_ANTIGUEDAD VALUES(seq_porc_com_annos.NEXTVAL,16,19,0.08);
INSERT INTO BONO_ANTIGUEDAD VALUES(seq_porc_com_annos.NEXTVAL,20,30,0.10);


 

INSERT INTO TICKETS_CONCIERTO  VALUES(1,'21/04' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE))   ,134560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(2,'13/04' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,125000,2000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(3,'21/04' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,138560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(4,'21/04' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,157893,2000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(5,'05/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,160000,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(6,'16/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,1258000,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(7,'16/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,158000,3000, 12642309);
INSERT INTO TICKETS_CONCIERTO  VALUES(8,'16/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,18000,3000, 11670042);
INSERT INTO TICKETS_CONCIERTO  VALUES(9,'17/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,28000,3000, 12648200);
INSERT INTO TICKETS_CONCIERTO  VALUES(10,'25/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,234560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(11,'26/05' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,257893,2000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(12,'01/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,14560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(13,'01/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,257893,2000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(14,'05/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,260000,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(15,'16/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,358000,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(16,'16/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,155000,3000, 12642309);
INSERT INTO TICKETS_CONCIERTO  VALUES(17,'16/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,125800,3000, 11670042);
INSERT INTO TICKETS_CONCIERTO  VALUES(18,'17/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,155800,3000, 12648200);
INSERT INTO TICKETS_CONCIERTO  VALUES(19,'21/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,234560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(20,'21/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,145793,2000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(21,'21/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,34560,1000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(22,'22/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,45793,2000, 12113369);
INSERT INTO TICKETS_CONCIERTO  VALUES(23,'22/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,160000,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(24,'23/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,75800,3000, 12456905);
INSERT INTO TICKETS_CONCIERTO  VALUES(25,'23/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,35800,3000, 12642309);
INSERT INTO TICKETS_CONCIERTO  VALUES(26,'16/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,55800,3000, 11670042);
INSERT INTO TICKETS_CONCIERTO  VALUES(27,'23/06' ||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) ,55800,3000, 12648200); 



INSERT INTO  COMISIONES_TICKET   VALUES(1, 540);
INSERT INTO  COMISIONES_TICKET   VALUES(2,786);
INSERT INTO  COMISIONES_TICKET   VALUES(3,618);
INSERT INTO  COMISIONES_TICKET   VALUES(4,7868);
INSERT INTO  COMISIONES_TICKET   VALUES(5,8500);
INSERT INTO  COMISIONES_TICKET   VALUES(6,9370);
INSERT INTO  COMISIONES_TICKET   VALUES(7,8370);
INSERT INTO  COMISIONES_TICKET   VALUES(8,3700);
INSERT INTO  COMISIONES_TICKET   VALUES(9,8700);
INSERT INTO  COMISIONES_TICKET   VALUES(10, 184);
INSERT INTO  COMISIONES_TICKET   VALUES(11,6868);
INSERT INTO  COMISIONES_TICKET   VALUES(12,514);
INSERT INTO  COMISIONES_TICKET   VALUES(13,6864);
INSERT INTO  COMISIONES_TICKET   VALUES(14,9000);
INSERT INTO  COMISIONES_TICKET   VALUES(15,730);
INSERT INTO  COMISIONES_TICKET   VALUES(16,9300);
INSERT INTO  COMISIONES_TICKET   VALUES(17,430);
INSERT INTO  COMISIONES_TICKET   VALUES(18,7300);
INSERT INTO  COMISIONES_TICKET   VALUES(19, 1514);
INSERT INTO  COMISIONES_TICKET   VALUES(20,6464);
INSERT INTO  COMISIONES_TICKET   VALUES(21,514);
INSERT INTO  COMISIONES_TICKET   VALUES(22,6864);
INSERT INTO  COMISIONES_TICKET   VALUES(23,9000);
INSERT INTO  COMISIONES_TICKET   VALUES(24,6370);
INSERT INTO  COMISIONES_TICKET   VALUES(25,9970);
INSERT INTO  COMISIONES_TICKET   VALUES(26,18370);
INSERT INTO  COMISIONES_TICKET   VALUES(27,4370);

COMMIT;

/* GENERACION DE ESTADISTICAS DE LAS TABLAS EN LA LA BASE DE DATOS NECESARIAS
PARA GENERAR PLANES DE EJECUCI�N Y TRABAJAR CON �NDICES */
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"AFP"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"ISAPRE"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"COMUNA_CIUDAD"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"TIPO_TRABAJADOR"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"ESTADO_CIVIL"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"BONO_ESCOLAR"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"TRABAJADOR"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"ASIGNACION_FAMILIAR"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"DETALLE_BONIFICACIONES_TRABAJADOR"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"TICKETS_CONCIERTO"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"BONO_ANTIGUEDAD"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"COMISIONES_TICKET"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_TABLE_STATS (ownname => '"PRY2205_S7"',tabname => '"EST_CIVIL"',estimate_percent => 100);
EXEC DBMS_STATS.GATHER_INDEX_STATS (ownname => 'PRY2205_S7', indname => 'PK_AFP');
EXEC DBMS_STATS.GATHER_INDEX_STATS (ownname => 'PRY2205_S7', indname => 'PK_ISAPRE');
EXEC DBMS_STATS.GATHER_INDEX_STATS (ownname => 'PRY2205_S7', indname => 'PK_CIUDAD');
EXEC DBMS_STATS.GATHER_INDEX_STATS (ownname => 'PRY2205_S7', indname => 'PK_TIPO_TRAB');
EXEC DBMS_STATS.GATHER_INDEX_STATS (ownname => 'PRY2205_S7', indname => 'PK_ESTADO_CIVIL_');
EXEC DBMS_STATS.GATHER_INDEX_STATS (ownname => 'PRY2205_S7', indname => 'PK_ESCOLARIDAD');
EXEC DBMS_STATS.GATHER_INDEX_STATS (ownname => 'PRY2205_S7', indname => 'PK_TRABAJADOR');
EXEC DBMS_STATS.GATHER_INDEX_STATS (ownname => 'PRY2205_S7', indname => 'PK_ASG_FAMILIAR');
EXEC DBMS_STATS.GATHER_INDEX_STATS (ownname => 'PRY2205_S7', indname => 'PK_DET_BONT');
EXEC DBMS_STATS.GATHER_INDEX_STATS (ownname => 'PRY2205_S7', indname => 'PK_ANNOS_TRABAJADOS');
EXEC DBMS_STATS.GATHER_INDEX_STATS (ownname => 'PRY2205_S7', indname => 'PK_EST_CIVIL');



ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/RRRR';


CREATE OR REPLACE SYNONYM syn_trabajador FOR trabajador;
CREATE OR REPLACE SYNONYM syn_bono_antiguedad FOR bono_antiguedad;
CREATE OR REPLACE SYNONYM syn_tickets_concierto FOR tickets_concierto;


-- ------------------------------
-- 1) Vista auxiliar: resumen de tickets por trabajador
--    (agrupa monto total por trabajador; facilita cálculo de bonificación por ticket)
-- ------------------------------
CREATE OR REPLACE VIEW vw_sum_tickets_trab AS
SELECT
    numrut_t,
    COUNT(*)       AS cnt_tickets,
    SUM(monto_ticket) AS suma_monto_ticket
FROM syn_tickets_concierto
GROUP BY numrut_t;

-- ------------------------------
-- 2) CASO 1: Simulación de bonificaciones e INSERT en DETALLE_BONIFICACIONES_TRABAJADOR
-- Reglas ticket:
--   - No hay ticket -> "No hay info"
--   - <= 50.000 -> 0%
--   - >50.000 and <=100.000 -> 5%
--   - >100.000 -> 7%
-- Regla antigüedad: non-equi join entre años trabajados y tabla bono_antiguedad
-- Filtro: isapre.porc_descto_isapre > 4  AND edad < 50
-- ------------------------------


SELECT
    t.numrut                                                        AS RUT,
    INITCAP(t.nombre || ' ' || t.appaterno || ' ' || t.apmaterno)    AS NOMBRE_COMPLETO,
    TO_CHAR( ROUND(t.sueldo_base, 0) )                               AS SUELDO_BASE,
    NVL( TO_CHAR( ROUND(vt.suma_monto_ticket,0) ), 'No hay info')    AS MONTO_TICKETS,
    -- bonif por ticket (numérico redondeado)
    ROUND(
        CASE
            WHEN vt.suma_monto_ticket IS NULL THEN 0
            WHEN vt.suma_monto_ticket <= 50000 THEN 0
            WHEN vt.suma_monto_ticket > 50000 AND vt.suma_monto_ticket <= 100000 THEN vt.suma_monto_ticket * 0.05
            ELSE vt.suma_monto_ticket * 0.07
        END
    ,0)                                                               AS BONIF_X_TICKET,
    -- simulación sumando sueldo base + bonif por ticket
    ROUND(
        t.sueldo_base
        +
        CASE
            WHEN vt.suma_monto_ticket IS NULL THEN 0
            WHEN vt.suma_monto_ticket <= 50000 THEN 0
            WHEN vt.suma_monto_ticket > 50000 AND vt.suma_monto_ticket <= 100000 THEN vt.suma_monto_ticket * 0.05
            ELSE vt.suma_monto_ticket * 0.07
        END
    ,0)                                                               AS SIMULACION_X_TICKET,
    FLOOR(MONTHS_BETWEEN(SYSDATE, t.fecing)/12)                       AS ANIOS_TRABAJADOS,
    NVL(ba.porcentaje,0)                                              AS PORC_BONO_ANTIGUEDAD,
    ROUND(t.sueldo_base * (1 + NVL(ba.porcentaje,0)),0)               AS SIMULACION_ANTIGUEDAD,
    NVL( TO_CHAR( (SELECT MIN(nro_ticket) FROM syn_tickets_concierto s WHERE s.numrut_t = t.numrut) ), 'No hay info') AS NUM_TICKET,
    t.direccion                                                       AS DIRECCION,
    i.nombre_isapre || ' (' || i.porc_descto_isapre || '%)'          AS SISTEMA_SALUD
FROM syn_trabajador t
LEFT JOIN vw_sum_tickets_trab vt ON vt.numrut_t = t.numrut
LEFT JOIN syn_bono_antiguedad ba
    ON FLOOR(MONTHS_BETWEEN(SYSDATE, t.fecing)/12) BETWEEN ba.limite_inferior AND ba.limite_superior
JOIN isapre i ON i.cod_isapre = t.cod_isapre
WHERE i.porc_descto_isapre > 4
  AND FLOOR(MONTHS_BETWEEN(SYSDATE, t.fecnac)/12) < 50
ORDER BY NVL(vt.suma_monto_ticket,0) DESC, NOMBRE_COMPLETO ASC;

-- 2.B) INSERT final en DETALLE_BONIFICACIONES_TRABAJADOR usando seq_det_bonif

INSERT INTO detalle_bonificaciones_trabajador (
    num,
    rut,
    nombre_trabajador,
    sueldo_base,
    num_ticket,
    direccion,
    sistema_salud,
    monto,
    bonif_x_ticket,
    simulacion_x_ticket,
    simulacion_antiguedad
)
SELECT
    seq_det_bonif.NEXTVAL,
    rut,
    nombre_trabajador,
    sueldo_base,
    num_ticket,
    direccion,
    sistema_salud,
    monto,
    bonif_x_ticket,
    simulacion_x_ticket,
    simulacion_antiguedad
FROM (
    SELECT
        TO_CHAR(t.numrut) AS rut,
        INITCAP(t.nombre || ' ' || t.appaterno || ' ' || t.apmaterno) AS nombre_trabajador,
        TO_CHAR( ROUND(t.sueldo_base,0) ) AS sueldo_base,
        NVL( TO_CHAR( (SELECT MIN(nro_ticket) FROM syn_tickets_concierto s2 WHERE s2.numrut_t = t.numrut) ), 'No hay info') AS num_ticket,
        t.direccion,
        i.nombre_isapre || ' (' || i.porc_descto_isapre || '%)' AS sistema_salud,
        NVL( TO_CHAR( ROUND(vt.suma_monto_ticket,0) ), 'No hay info' ) AS monto,
        TO_CHAR(
            ROUND(
                CASE
                    WHEN vt.suma_monto_ticket IS NULL THEN 0
                    WHEN vt.suma_monto_ticket <= 50000 THEN 0
                    WHEN vt.suma_monto_ticket <= 100000 THEN vt.suma_monto_ticket * 0.05
                    ELSE vt.suma_monto_ticket * 0.07
                END
            ,0)
        ) AS bonif_x_ticket,
        TO_CHAR(
            ROUND(
                t.sueldo_base
                +
                CASE
                    WHEN vt.suma_monto_ticket IS NULL THEN 0
                    WHEN vt.suma_monto_ticket <= 50000 THEN 0
                    WHEN vt.suma_monto_ticket <= 100000 THEN vt.suma_monto_ticket * 0.05
                    ELSE vt.suma_monto_ticket * 0.07
                END
            ,0)
        ) AS simulacion_x_ticket,
        TO_CHAR( ROUND( t.sueldo_base * (1 + NVL(ba.porcentaje,0)), 0) ) AS simulacion_antiguedad
    FROM syn_trabajador t
    LEFT JOIN vw_sum_tickets_trab vt ON vt.numrut_t = t.numrut
    LEFT JOIN syn_bono_antiguedad ba
        ON FLOOR(MONTHS_BETWEEN(SYSDATE, t.fecing)/12) BETWEEN ba.limite_inferior AND ba.limite_superior
    JOIN isapre i ON i.cod_isapre = t.cod_isapre
    WHERE i.porc_descto_isapre > 4
      AND FLOOR(MONTHS_BETWEEN(SYSDATE, t.fecnac)/12) < 50
    ORDER BY NVL(vt.suma_monto_ticket,0) DESC,
             INITCAP(t.nombre || ' ' || t.appaterno || ' ' || t.apmaterno) ASC
);

COMMIT;


-- 3) CASO 2 - VISTA V_AUMENTOS_ESTUDIO
--    - Solo trabajadores con tipo 'CAJERO'
--    - Incluir solo los cajeros que tienen entre 1 y 2 cargas 


CREATE OR REPLACE VIEW V_AUMENTOS_ESTUDIO AS
SELECT
    t.numrut                                                   AS RUT,
    INITCAP(t.nombre || ' ' || t.appaterno || ' ' || t.apmaterno) AS NOMBRE_COMPLETO,
    be.descrip                                                 AS NIVEL_EDUCACION,
    NVL(be.porc_bono,0)                                        AS PORC_BONO_ESTUDIO,
    TO_CHAR( ROUND(t.sueldo_base,0) )                          AS SUELDO_ACTUAL,
    TO_CHAR( ROUND( t.sueldo_base * (NVL(be.porc_bono,0) / 100), 0) ) AS AUMENTO_CALCULADO,
    TO_CHAR( ROUND( t.sueldo_base + (t.sueldo_base * (NVL(be.porc_bono,0) / 100)), 0) ) AS SUELDO_SIMULADO,
    (
        SELECT COUNT(*) FROM asignacion_familiar af WHERE af.numrut_t = t.numrut
    ) AS CANT_CARGAS
FROM trabajador t
JOIN bono_escolar be ON be.id_escolar = t.id_escolaridad_t
JOIN tipo_trabajador tt ON tt.id_categoria = t.id_categoria_t
WHERE UPPER(tt.desc_categoria) = 'CAJERO'
  AND (
        SELECT COUNT(*) FROM asignacion_familiar af2 WHERE af2.numrut_t = t.numrut
      ) BETWEEN 1 AND 2
ORDER BY PORC_BONO_ESTUDIO ASC, NOMBRE_COMPLETO ASC;


-- 4) CASO 2 Etapa 2 - Optimización (Índices)
--    - Crear índice B-Tree sobre apmaterno
--    - Crear índice function-based para UPPER(apmaterno)


BEGIN
  
    BEGIN
        EXECUTE IMMEDIATE 'DROP INDEX idx_trab_apmaterno';
    EXCEPTION WHEN OTHERS THEN
        NULL; -
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP INDEX idx_trab_apmaterno_upper';
    EXCEPTION WHEN OTHERS THEN
        NULL;
    END;
END;
/

-- crear índices nuevos
CREATE INDEX idx_trab_apmaterno ON trabajador(apmaterno);

-- function-based index para consultas que usan UPPER(apmaterno)
CREATE INDEX idx_trab_apmaterno_upper ON trabajador( UPPER(apmaterno) );

-- actualizar estadísticas para que el optimizador use los índices creados
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(ownname => USER, tabname => 'TRABAJADOR', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE);
    DBMS_STATS.GATHER_INDEX_STATS(ownname => USER, indname => 'IDX_TRAB_APMATERNO');
    DBMS_STATS.GATHER_INDEX_STATS(ownname => USER, indname => 'IDX_TRAB_APMATERNO_UPPER');
EXCEPTION WHEN OTHERS THEN
    NULL; 
END;
/


-- Consulta simple (sin UPPER)
SELECT t.numrut, t.nombre, t.appaterno, t.apmaterno, i.nombre_isapre
FROM trabajador t
JOIN isapre i ON i.cod_isapre = t.cod_isapre
WHERE t.apmaterno = 'CASTILLO';

-- Consulta con UPPER (debería usar el function-based index)
SELECT t.numrut, t.nombre, t.appaterno, t.apmaterno, i.nombre_isapre
FROM trabajador t
JOIN isapre i ON i.cod_isapre = t.cod_isapre
WHERE UPPER(t.apmaterno) = 'CASTILLO';

