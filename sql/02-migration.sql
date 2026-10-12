-- ============================================
-- SAE S2.04 migration des donnees
-- ============================================

-- Migration des donnees de qualite_air dans la table qualite
insert into qualite (code_qual, lib_qual, coul_qual) values 
    (1, 'Bon', '#50F0E6'),
    (2, 'Moyen', '#50CCAA'),
    (3, 'Dégradé', '#F0E641'),
    (4, 'Mauvais', '#FF5050'),
    (5, 'Très mauvais', '#C73D6B'),  
    (6, 'Extrêmement mauvais', '#BF0EF5');  

-- Migration des données dans la table ville : on utilise la table qualite_air pour récupérer les informations sur les villes 
-- et les départements dont le code est composé de 5 chiffres
insert into ville (
    code_zone, 
    lib_zone, 
    type_zone, 
    x_wgs84, 
    y_wgs84, 
    x_reg, y_reg, 
    num_dep)
select distinct  
    code_zone,
    lib_zone,
    type_zone,
    x_wgs84,
    y_wgs84,
    x_reg,
    y_reg,
    substring(code_zone::varchar, 1, 2)
from qualite_air
where length(code_zone::varchar) = 5;

-- Migration des données dans la table ville : on utilise la table qualite_air pour récupérer les informations sur les villes 
-- et les départements dont le code est composé de 4 chiffres
insert into ville (
    code_zone, 
    lib_zone, 
    type_zone, 
    x_wgs84, 
    y_wgs84, 
    x_reg, 
    y_reg, 
    num_dep)
select distinct 
    code_zone,
    lib_zone,
    type_zone,
    x_wgs84,
    y_wgs84,
    x_reg,
    y_reg,
    substring(code_zone::varchar, 1, 1)
from qualite_air
where length(code_zone::varchar) = 4;

-- Migration des donnees de qualite_air vers la table mesure
INSERT INTO mesure (
    OBJECTID, 
    date_ech, 
    date_dif, 
    source, 
    code_zone, 
    code_qual,
    code_no2, 
    code_so2, 
    code_o3, 
    code_pm10, 
    code_pm25,
    conc_no2, 
    conc_so2, 
    conc_o3, 
    conc_pm10, 
    conc_pm25
)
SELECT 
    OBJECTID, 
    date_ech,
    date_dif,
    source, 
    code_zone, 
    code_qual,
    code_no2, 
    code_so2, 
    code_o3, 
    code_pm10, 
    code_pm25,
    conc_no2, 
    conc_so2, 
    conc_o3, 
    conc_pm10, 
    conc_pm25
FROM qualite_air;