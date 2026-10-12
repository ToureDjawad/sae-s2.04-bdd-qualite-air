-- Les tables normalisées sont dans public, la table brute importée dans sae_qualite_air
SET search_path = public, sae_qualite_air;

-- ============================================================
-- SAE S2.04 - PARTIE 2 : Requetes analytiques
-- ============================================================

-- 1. Quelle ville (libellé et code de la zone) a la plus mauvaise moyenne d'indice de qualité de l’air
-- (classe de l’indice pour la ville) !!

select lib_zone, code_zone, avg(code_qual) as "moyenne"
from mesure
join ville using(code_zone)
group by code_zone, lib_zone
order by moyenne desc
limit 1;


-- 2. Pour chaque ville afficher son libellé, son code zone, son indice  de qualité de l'air, la moyenne
-- de son indice de qualité de l'air et le max de son indice de qualité de l'air.
-- On veut un résultat sous la forme suivante :

select lib_zone,
    code_zone,
    code_qual,
    avg(code_qual) over (partition by code_zone) as "moyenne",   
    max(code_qual) over (partition by code_zone) as "maximum"
from mesure
join ville using(code_zone)
where code_qual is not null
order by lib_zone;

-- 3. Pour chaque département afficher son numéro, son indice moyen de qualité de l'air, le
-- maximum de son indice de qualité de l'air et le classement du meilleur département : au rang 1
-- celui qui a la meilleur moyenne de son indice de qualité de l'air(la plus basse) et au rang n celui
-- qui la moins bonne moyenne !

select d.num_dep,
    d.nom_departement,
    avg(m.code_qual) as "moyenne_indice",
    max(m.code_qual) as "max_indice",
    rank() over (order by avg(m.code_qual)) as "classement meilleur indice"
from mesure m
join ville using(code_zone)
join departement d using(num_dep)
group by d.num_dep, d.nom_departement
order by "classement meilleur indice";

-- 4. Pour le département de l'Ain, afficher le numéro de département, le nom de la ville et la valeur
-- maximum de concentration pm10 de la ville qui en a le plus.

select d.num_dep,
    d.nom_departement,
    v.lib_zone,
    max(m.conc_pm10) as "max par ville"
from mesure m
join ville v using(code_zone)
join departement d using(num_dep)
where d.nom_departement = 'Ain'
group by d.num_dep, d.nom_departement, v.lib_zone
order by "max par ville" desc
limit 1;

-- 5. Pour chaque département, afficher le numéro de département, le nom de la ville et la valeur
-- maximum de concentration pm10 de la ville (du département) qui en a le plus 

with mesures_enrichies as (
    select departement.num_dep,
        departement.nom_departement,
        ville.lib_zone,
        mesure.conc_pm10,
        max(mesure.conc_pm10) over (partition by departement.num_dep) as "max_pm10_dep"
    from mesure
    join ville using(code_zone)
    join departement using(num_dep)
)
select num_dep, nom_departement, lib_zone, "max_pm10_dep"
from mesures_enrichies
where conc_pm10 = max_pm10_dep
order by num_dep;

-- 6. Pour chaque département afficher le nombre de bon indice de qualité de l'air, le nombre de bon
-- indice de qualité de pm10 et le nombre de bon indice de qualité de l'air de o3 (code_qualite=1,
-- code_qualit_pm10=1, code_qualit_o3=1 )

with 
bon_indice as (
    select d.num_dep, count(*) as nbi
    from mesure m
    join ville v  using(code_zone)
    join departement d using(num_dep)
    where m.code_qual = 1
    group by d.num_dep
),
bon_pm10 as (
    select d.num_dep, count(*) as nbb
    from mesure m
    join ville v using(code_zone)
    join departement d using(num_dep)
    where m.code_pm10 = 1
    group by d.num_dep
),
bon_o3 as (
    select d.num_dep, count(*) as nbo
    from mesure m
    join ville v using(code_zone)
    join departement d using(num_dep)
    where m.code_o3 = 1
    group by d.num_dep
)
select bi.num_dep,
       d.nom_departement,
       bi.nbi as "nb_bon_indice",
       bp.nbb as "nb_bon_pm10",
       bo.nbo as "nb_bon_o3"
from bon_indice bi
join bon_pm10 bp using(num_dep)
join bon_o3 bo using(num_dep)
join departement d using(num_dep)
order by bi.num_dep;



-- 7. Pour chaque département afficher le nombre de bon indice de qualité de l'air et son rang (rang
-- 1 qui a le plus de bon indice), le nombre de bon indice de qualité de pm10 et son rang (rang 1
-- qui a le plus de bon indice) et enfin le nombre de bon indice de qualité de l'air de o3 et son
-- rang (rang 1 qui a le plus de bon indice)


with 
bon_indice as (
    select d.num_dep, count(*) as nbi
    from mesure m
    join ville v using(code_zone)
    join departement d using(num_dep)
    where m.code_qual = 1
    group by d.num_dep
),
bon_pm10 as (
    select d.num_dep, count(*) as nbp
    from mesure m
    join ville v using(code_zone)
    join departement d using(num_dep)
    where m.code_pm10 = 1
    group by d.num_dep
),
bon_o3 as (
    select d.num_dep, count(*) as nbo
    from mesure m
    join ville v using(code_zone)
    join departement d using(num_dep)
    where m.code_o3 = 1
    group by d.num_dep
)
select bi.num_dep,
    d.nom_departement,
    bi.nbi as nb_bon_indice,
    rank() over (order by bi.nbi desc) as "rang_bon_indice",
    bp.nbp as nb_bon_pm10,
    rank() over (order by bp.nbp desc) as "rang_bon_pm10",
    bo.nbo as nb_bon_o3,
    rank() over (order by bo.nbo desc) as "rang_bon_o3"
from bon_indice bi
join bon_pm10 bp using(num_dep)
join bon_o3 bo using(num_dep)
join departement d using(num_dep)
order by bi.num_dep;