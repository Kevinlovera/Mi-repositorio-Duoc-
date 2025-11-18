

SELECT
    UPPER(t.appaterno || ' ' || t.apmaterno || ' ' || t.nombre) AS "Nombre Completo Trabajador",
    TO_CHAR(t.numrut, 'FM99G999G999') || '-' || t.dvrut         AS "RUT Trabajador",
    tt.desc_categoria                                           AS "Tipo Trabajador",
    UPPER(c.nombre_ciudad)                                     AS "Ciudad Trabajador",
    TO_CHAR(t.sueldo_base, 'FM$999G999G999')                   AS "Sueldo Base"
FROM trabajador t
JOIN tipo_trabajador tt ON t.id_categoria_t = tt.id_categoria
JOIN comuna_ciudad c    ON t.id_ciudad      = c.id_ciudad
WHERE t.sueldo_base BETWEEN 650000 AND 3000000
ORDER BY
    c.nombre_ciudad DESC,
    t.sueldo_base   ASC;



SELECT
    TO_CHAR(t.numrut, 'FM99G999G999') || '-' || t.dvrut AS "RUT Trabajador",
    UPPER(t.nombre || ' ' || t.appaterno)              AS "Nombre Trabajador",
    COUNT(*)                                           AS "Total Tickets",
    SUM(tc.monto_ticket)                               AS "Total Vendido",
    SUM(ct.valor_comision)                             AS "Comisión Total",
    tt.desc_categoria                                  AS "Tipo Trabajador",
    UPPER(c.nombre_ciudad)                             AS "Ciudad Trabajador"
FROM trabajador t
JOIN tipo_trabajador tt   ON t.id_categoria_t = tt.id_categoria
JOIN comuna_ciudad c      ON t.id_ciudad      = c.id_ciudad
JOIN tickets_concierto tc ON t.numrut         = tc.numrut_t
JOIN comisiones_ticket ct ON tc.nro_ticket    = ct.nro_ticket
WHERE tt.desc_categoria = 'CAJERO'
GROUP BY
    t.numrut, t.dvrut,
    t.nombre, t.appaterno,
    tt.desc_categoria,
    c.nombre_ciudad
HAVING
    SUM(tc.monto_ticket) > 50000
ORDER BY
    SUM(tc.monto_ticket) DESC;



SELECT
    -- RUT formateado
    TO_CHAR(t.numrut, 'FM99G999G999') || '-' || t.dvrut AS "RUT Trabajador",

    -- Nombre completo
    INITCAP(t.nombre || ' ' || t.appaterno || ' ' || t.apmaterno) AS "Trabajador Nombre",

    -- Año de ingreso
    EXTRACT(YEAR FROM t.fecing) AS "Año Ingreso",

    -- Años trabajados
    TRUNC(MONTHS_BETWEEN(SYSDATE, t.fecing) / 12) AS "Años Antigüedad",

    -- Número de cargas
    NVL(COUNT(afam.numrut_carga), 0) AS "Num. Cargas Familiares",

    -- Nombre isapre
    i.nombre_isapre AS "Nombre Isapre",

    -- Sueldo base
    t.sueldo_base AS "Sueldo Base",

    -- Bono FONASA 1%
    CASE
        WHEN i.nombre_isapre = 'FONASA'
        THEN ROUND(t.sueldo_base * 0.01, 0)
        ELSE 0
    END AS "Bono FONASA",

    -- Bono antigüedad: 10% hasta 10 años, 15% desde 11 en adelante
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, t.fecing) / 12) <= 10
            THEN ROUND(t.sueldo_base * 0.10, 0)
        ELSE ROUND(t.sueldo_base * 0.15, 0)
    END AS "Bono Antigüedad",

    -- AFP
    a.nombre_afp AS "Nombre AFP",

    -- Estado civil vigente
    ec2.desc_estcivil AS "Estado Civil"

FROM trabajador t
LEFT JOIN asignacion_familiar afam
       ON t.numrut = afam.numrut_t
JOIN afp a
       ON t.cod_afp = a.cod_afp
JOIN isapre i
       ON t.cod_isapre = i.cod_isapre
JOIN est_civil ec
       ON t.numrut = ec.numrut_t
JOIN estado_civil ec2
       ON ec.id_estcivil_est = ec2.id_estcivil

WHERE
    -- Estado civil vigente (sin fecha fin o con fecha fin mayor a hoy)
    ec.fecter_estcivil IS NULL
    OR ec.fecter_estcivil > SYSDATE

GROUP BY
    t.numrut, t.dvrut,
    t.nombre, t.appaterno, t.apmaterno,
    t.fecing,
    i.nombre_isapre,
    t.sueldo_base,
    a.nombre_afp,
    ec2.desc_estcivil

ORDER BY
    t.numrut ASC;

