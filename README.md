# SQL Data-Analytics Projekt – NASA Exoplanets

Dieses Repository enthält alle relevanten Materialien und SQL-Skripte für ein SQL-basiertes Datenanalyseprojekt im Rahmen des IHK Data Analyst Abschlussprojekts. Ziel ist es, den NASA Exoplaneten-Datensatz in eine PostgreSQL-Datenbank zu überführen, zu normalisieren und darauf basierend analytische Auswertungen durchzuführen.

## Projektüberblick

- **Datenquelle:** NASA Exoplanet Archive (CSV-Datei)
- **Datenbank:** PostgreSQL
- **Schwerpunkte:** Datenmodellierung, Datenbanknormalisierung, Benutzer- und Rechteverwaltung, Analytik (SQL, Python)

## Projektstruktur

- **init/**
  - Notebooks & SQL für das Anlegen der Datenbank und Laden der Rohdaten (`init_create_db.ipynb`, `init_insert_data.ipynb`)
- **database/**
  - Datendateien (`cleaned_exoplanet_data.csv`)
- **normalization/**
  - Schrittweise Normalisierung der Datenbanktabellen (`normalization_db.md`)
- **usermanagement/**
  - Skripte für Benutzer- und Rechteverwaltung (`role_user_management.sql`)
- **data\_analytics/**
  - SQL- und Python-Skripte für Slicing, Analysen und Visualisierung

## Workflow im Überblick

1. **Anlegen der Datenbank:**
   - Siehe `init/init_create_db.ipynb`
   - Tabellen für Rohdaten (`old_data`) und normalisierte Daten (`new_data`) werden erstellt
2. **Import und Normalisierung der Daten:**
   - Import der CSV-Datei in die Rohdatentabelle
   - Normalisierung der Daten gemäß 3NF, Zerlegung in Subtabellen
   - Detaillierte Beschreibung im Markdown `normalization/normalization_db.md`
3. **Benutzer- und Rechteverwaltung:**
   - Vergabe von Rollen, Rechte- und Nutzerverwaltung (siehe `usermanagement/role_user_management.sql`)
4. **Analytik:**
   - SQL-Analysen und Slicing (z.B. mit Window Functions, Aggregationen, Joins)
   - Python-basierte Auswertung in Notebooks

## Voraussetzungen

- PostgreSQL >= 13
- Python >= 3.9 (Optional für Jupyter/Pandas-Auswertung)
- Empfohlene Tools: DBeaver, VS Code, JupyterLab

## Einrichtung

1. Repository klonen:
   ```bash
   git clone https://github.com/HyBRiZx420/SQL_DA_Project.git
   ```
2. Datenbank anlegen und Zugangsdaten konfigurieren
3. SQL-Skripte im Ordner `init` und `normalization` der Reihe nach ausführen
4. Datenbankverbindung für Python-Notebooks anpassen (siehe `init/*.ipynb`)

## Hinweise & Tipps

- Die Datei `cleaned_exoplanet_data.csv` befindet sich im Ordner `database` und kann direkt in PostgreSQL importiert werden.
- Bei Fehlern bzgl. Benutzer/Passwort bitte Hinweise in den jeweiligen SQL-Skripten beachten.
- Analytische SQL-Beispiele finden sich derzeit nicht im Repo.
- Für Visualisierungen empfehlen sich Jupyter Notebooks mit Pandas & Matplotlib.

## Kontakt

Projektverantwortlicher: [Hybriz](mailto\:irgendwasmitdata@web.de)

---

*Diese README wurde automatisch erstellt und auf Basis der vorhandenen Projektstruktur sowie exemplarischer SQL- und Markdown-Dateien generiert.*

