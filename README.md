# Base de données qualité de l'air | SAÉ 2.04

Conception d'une base PostgreSQL à partir du jeu de données ouvert ATMO sur l'indice de qualité de l'air, puis analyse statistique des mesures. SAÉ 2.04 « Exploitation d'une base de données » du BUT Informatique (IUT d'Aix-Marseille, site d'Arles).

**Auteurs :** Mamadou Bailo BARRY et Djawad TOURE ISSAHOU

## Contenu

| Dossier | Contenu |
| --- | --- |
| `docs/` | Diagramme UML, modèle physique de données et argumentation des choix |
| `sql/00-import-qualite-air.sql` | Table brute importée depuis le jeu de données ATMO |
| `sql/01-creation-tables.sql` | Schéma normalisé (qualité, ville, département, mesure...) avec clés et contraintes |
| `sql/02-migration.sql` | Migration de la table brute vers le schéma normalisé |
| `sql/03-requetes-analytiques.sql` | Requêtes d'analyse : jointures, agrégats, fonctions de fenêtre |
| `analyse/` | Notebook Python (pandas) : statistiques descriptives et multivariées |

## Exemple de requête

```sql
-- Indice, moyenne et maximum de l'indice pour chaque ville
SELECT lib_zone, code_zone, code_qual,
       avg(code_qual) OVER (PARTITION BY code_zone) AS moyenne,
       max(code_qual) OVER (PARTITION BY code_zone) AS maximum
FROM mesure
JOIN ville USING (code_zone)
WHERE code_qual IS NOT NULL
ORDER BY lib_zone;
```

## Exécution

```bash
createdb qualite_air
psql -d qualite_air -f sql/00-import-qualite-air.sql
psql -d qualite_air -f sql/01-creation-tables.sql
psql -d qualite_air -f sql/02-migration.sql
psql -d qualite_air -f sql/03-requetes-analytiques.sql
```

Pour l'analyse : `jupyter notebook analyse/analyse-qualite-air.ipynb` depuis le dossier `analyse/`.

Données : indice de qualité de l'air ATMO, publié en données ouvertes par les associations agréées de surveillance de la qualité de l'air.
