/*==============================================================*/
/* Table : region                                               */
/*==============================================================*/
create table region (
id_region            serial               not null,
lib_region           varchar              null,
descript_region      varchar              null,
constraint PK_REGION primary key (id_region)
);

/*==============================================================*/
/* Index : REGION_PK                                            */
/*==============================================================*/
create unique index REGION_PK on region (
id_region
);


/*==============================================================*/
/* Table : departement                                          */
/*==============================================================*/
create table departement (
num_dep				varchar              not null,
id_region            INT                  not null,
nom_departement      varchar                  null,
constraint PK_DEPARTEMENT primary key (num_dep)
);

/*==============================================================*/
/* Index : DEPARTEMENT_PK                                       */
/*==============================================================*/
create unique index DEPARTEMENT_PK on departement (
num_dep
);



alter table departement
   add constraint FK_dep_region foreign key (id_region)
      references region (id_region)
      on delete restrict on update restrict;  

/*==============================================================*/
/* Table : ville                                                */
/*==============================================================*/	  

create table ville (
    code_zone varchar  primary key not null,
    lib_zone    varchar(255) not null,
    type_zone   varchar(100),
    x_wgs84     real,
    y_wgs84     real,
    x_reg       real,
    y_reg       real,
    num_dep     varchar(3)  not null,
    constraint FK_ZONE_DEP foreign key (num_dep) references departement (num_dep)
);
/*==============================================================*/
/* Table : qualite                                              */
/*==============================================================*/
create table qualite (
    code_qual   int primary key not null,
    lib_qual    varchar(100) not null,
    coul_qual   varchar(100),
    constraint CHK_QUALITE_CODE check (code_qual >= 1 and code_qual <= 6)
);

/*==============================================================*/
/* Table : mesure                                              */
/*==============================================================*/
create table mesure (
    OBJECTID    int primary key not null,
    date_ech    timestamp not null,
    date_dif    timestamp not null,
    source      varchar(255),
    code_zone   varchar(5) not null,
    code_qual   int not null,
    code_no2    int,
    code_so2    int,
    code_o3     int,
    code_pm10   int,
    code_pm25   int,
    conc_no2    real,
    conc_so2    real,
    conc_o3     real,
    conc_pm10   real,
    conc_pm25   real,
    constraint FK_MESURE_ZONE foreign key (code_zone) references ville (code_zone),
    constraint FK_MESURE_QUALITE foreign key (code_qual) references qualite (code_qual)
);


-- ajout des regions
-- 

INSERT INTO region VALUES (1, 'Guadeloupe', NULL);
INSERT INTO region VALUES (2, 'Martinique', NULL);
INSERT INTO region VALUES (3, 'Guyane', NULL);
INSERT INTO region VALUES (4, 'La Réunion', NULL);
INSERT INTO region VALUES (6, 'Mayotte', NULL);
INSERT INTO region VALUES (11, 'Île-de-France', NULL);
INSERT INTO region VALUES (24, 'Centre-Val de Loire', NULL);
INSERT INTO region VALUES (27, 'Bourgogne-Franche-Comté', NULL);
INSERT INTO region VALUES (28, 'Normandie', NULL);
INSERT INTO region VALUES (32, 'Hauts-de-France', NULL);
INSERT INTO region VALUES (44, 'Grand Est', NULL);
INSERT INTO region VALUES (52, 'Pays de la Loire', NULL);
INSERT INTO region VALUES (53, 'Bretagne', NULL);
INSERT INTO region VALUES (75, 'Nouvelle-Aquitaine', NULL);
INSERT INTO region VALUES (76, 'Occitanie', NULL);
INSERT INTO region VALUES (84, 'Auvergne-Rhône-Alpes', NULL);
INSERT INTO region VALUES (93, 'Provence-Alpes-Côte d''Azur', NULL);
INSERT INTO region VALUES (94, 'Corse', NULL);


-- ajout des departements et du lien avec les regions
-- 
insert into departement (num_dep,nom_departement,id_region) values ('1','Ain',84);
insert into departement (num_dep,nom_departement,id_region) values ('3','Allier',84);
insert into departement (num_dep,nom_departement,id_region) values ('7','Ardèche',84);
insert into departement (num_dep,nom_departement,id_region) values ('15','Cantal',84);
insert into departement (num_dep,nom_departement,id_region) values ('26','Drôme',84);
insert into departement (num_dep,nom_departement,id_region) values ('38','Isère',84);
insert into departement (num_dep,nom_departement,id_region) values ('42','Loire',84);
insert into departement (num_dep,nom_departement,id_region) values ('43','Haute-Loire',84);
insert into departement (num_dep,nom_departement,id_region) values ('63','Puy-de-Dôme',84);
insert into departement (num_dep,nom_departement,id_region) values ('69','Rhône',84);
insert into departement (num_dep,nom_departement,id_region) values ('73','Savoie',84);
insert into departement (num_dep,nom_departement,id_region) values ('74','Haute-Savoie',84);
insert into departement (num_dep,nom_departement,id_region) values ('75','Paris',11);
insert into departement (num_dep,nom_departement,id_region) values ('77','Seine-et-Marne',11);
insert into departement (num_dep,nom_departement,id_region) values ('78','Yvelines',11);
insert into departement (num_dep,nom_departement,id_region) values ('91','Essonne',11);
insert into departement (num_dep,nom_departement,id_region) values ('92','Hauts-de-Seine',11);
insert into departement (num_dep,nom_departement,id_region) values ('93','Seine-Saint-Denis',11);
insert into departement (num_dep,nom_departement,id_region) values ('94','Val-de-Marne',11);
insert into departement (num_dep,nom_departement,id_region) values ('95','Val-d''Oise',11);
insert into departement (num_dep,nom_departement,id_region) values ('21','Côte-d''Or',27);
insert into departement (num_dep,nom_departement,id_region) values ('25','Doubs',27);
insert into departement (num_dep,nom_departement,id_region) values ('39','Jura',27);
insert into departement (num_dep,nom_departement,id_region) values ('58','Nièvre',27);
insert into departement (num_dep,nom_departement,id_region) values ('70','Haute-Saône',27);
insert into departement (num_dep,nom_departement,id_region) values ('71','Saône-et-Loire',27);
insert into departement (num_dep,nom_departement,id_region) values ('89','Yonne',27);
insert into departement (num_dep,nom_departement,id_region) values ('90','Territoire de Belfort',27);
insert into departement (num_dep,nom_departement,id_region) values ('22','Côtes-d''Armor',53);
insert into departement (num_dep,nom_departement,id_region) values ('29','Finistère',53);
insert into departement (num_dep,nom_departement,id_region) values ('35','Ille-et-Vilaine',53);
insert into departement (num_dep,nom_departement,id_region) values ('56','Morbihan',53);
insert into departement (num_dep,nom_departement,id_region) values ('18','Cher',24);
insert into departement (num_dep,nom_departement,id_region) values ('28','Eure-et-Loir',24);
insert into departement (num_dep,nom_departement,id_region) values ('36','Indre',24);
insert into departement (num_dep,nom_departement,id_region) values ('37','Indre-et-Loire',24);
insert into departement (num_dep,nom_departement,id_region) values ('41','Loir-et-Cher',24);
insert into departement (num_dep,nom_departement,id_region) values ('45','Loiret',24);
insert into departement (num_dep,nom_departement,id_region) values ('2A','Corse-du-Sud',94);
insert into departement (num_dep,nom_departement,id_region) values ('2B','Haute-Corse',94);
insert into departement (num_dep,nom_departement,id_region) values ('8','Ardennes',44);
insert into departement (num_dep,nom_departement,id_region) values ('10','Aube',44);
insert into departement (num_dep,nom_departement,id_region) values ('51','Marne',44);
insert into departement (num_dep,nom_departement,id_region) values ('52','Haute-Marne',44);
insert into departement (num_dep,nom_departement,id_region) values ('54','Meurthe-et-Moselle',44);
insert into departement (num_dep,nom_departement,id_region) values ('55','Meuse',44);
insert into departement (num_dep,nom_departement,id_region) values ('57','Moselle',44);
insert into departement (num_dep,nom_departement,id_region) values ('67','Bas-Rhin',44);
insert into departement (num_dep,nom_departement,id_region) values ('68','Haut-Rhin',44);
insert into departement (num_dep,nom_departement,id_region) values ('88','Vosges',44);
insert into departement (num_dep,nom_departement,id_region) values ('971','Guadeloupe',1);
insert into departement (num_dep,nom_departement,id_region) values ('973','Guyane',3);
insert into departement (num_dep,nom_departement,id_region) values ('2','Aisne',32);
insert into departement (num_dep,nom_departement,id_region) values ('59','Nord',32);
insert into departement (num_dep,nom_departement,id_region) values ('60','Oise',32);
insert into departement (num_dep,nom_departement,id_region) values ('62','Pas-de-Calais',32);
insert into departement (num_dep,nom_departement,id_region) values ('80','Somme',32);
insert into departement (num_dep,nom_departement,id_region) values ('974','La Réunion',4);
insert into departement (num_dep,nom_departement,id_region) values ('972','Martinique',2);
insert into departement (num_dep,nom_departement,id_region) values ('976','Mayotte',6);
insert into departement (num_dep,nom_departement,id_region) values ('14','Calvados',28);
insert into departement (num_dep,nom_departement,id_region) values ('27','Eure',28);
insert into departement (num_dep,nom_departement,id_region) values ('50','Manche',28);
insert into departement (num_dep,nom_departement,id_region) values ('61','Orne',28);
insert into departement (num_dep,nom_departement,id_region) values ('76','Seine-Maritime',28);
insert into departement (num_dep,nom_departement,id_region) values ('16','Charente',75);
insert into departement (num_dep,nom_departement,id_region) values ('17','Charente-Maritime',75);
insert into departement (num_dep,nom_departement,id_region) values ('19','Corrèze',75);
insert into departement (num_dep,nom_departement,id_region) values ('23','Creuse',75);
insert into departement (num_dep,nom_departement,id_region) values ('24','Dordogne',75);
insert into departement (num_dep,nom_departement,id_region) values ('33','Gironde',75);
insert into departement (num_dep,nom_departement,id_region) values ('40','Landes',75);
insert into departement (num_dep,nom_departement,id_region) values ('47','Lot-et-Garonne',75);
insert into departement (num_dep,nom_departement,id_region) values ('64','Pyrénées-Atlantiques',75);
insert into departement (num_dep,nom_departement,id_region) values ('79','Deux-Sèvres',75);
insert into departement (num_dep,nom_departement,id_region) values ('86','Vienne',75);
insert into departement (num_dep,nom_departement,id_region) values ('87','Haute-Vienne',75);
insert into departement (num_dep,nom_departement,id_region) values ('9','Ariège',76);
insert into departement (num_dep,nom_departement,id_region) values ('11','Aude',76);
insert into departement (num_dep,nom_departement,id_region) values ('12','Aveyron',76);
insert into departement (num_dep,nom_departement,id_region) values ('30','Gard',76);
insert into departement (num_dep,nom_departement,id_region) values ('31','Haute-Garonne',76);
insert into departement (num_dep,nom_departement,id_region) values ('32','Gers',76);
insert into departement (num_dep,nom_departement,id_region) values ('34','Hérault',76);
insert into departement (num_dep,nom_departement,id_region) values ('46','Lot',76);
insert into departement (num_dep,nom_departement,id_region) values ('48','Lozère',76);
insert into departement (num_dep,nom_departement,id_region) values ('65','Hautes-Pyrénées',76);
insert into departement (num_dep,nom_departement,id_region) values ('66','Pyrénées-Orientales',76);
insert into departement (num_dep,nom_departement,id_region) values ('81','Tarn',76);
insert into departement (num_dep,nom_departement,id_region) values ('82','Tarn-et-Garonne',76);
insert into departement (num_dep,nom_departement,id_region) values ('44','Loire-Atlantique',52);
insert into departement (num_dep,nom_departement,id_region) values ('49','Maine-et-Loire',52);
insert into departement (num_dep,nom_departement,id_region) values ('53','Mayenne',52);
insert into departement (num_dep,nom_departement,id_region) values ('72','Sarthe',52);
insert into departement (num_dep,nom_departement,id_region) values ('85','Vendée',52);
insert into departement (num_dep,nom_departement,id_region) values ('4','Alpes-de-Haute-Provence',93);
insert into departement (num_dep,nom_departement,id_region) values ('5','Hautes-Alpes',93);
insert into departement (num_dep,nom_departement,id_region) values ('6','Alpes-Maritimes',93);
insert into departement (num_dep,nom_departement,id_region) values ('13','Bouches-du-Rhône',93);
insert into departement (num_dep,nom_departement,id_region) values ('83','Var',93);
insert into departement (num_dep,nom_departement,id_region) values ('84','Vaucluse',93);
