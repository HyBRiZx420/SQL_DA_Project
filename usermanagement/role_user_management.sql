
CREATE ROLE read_only_role;

GRANT CONNECT ON DATABASE nasa_exoplanets TO read_only_role;

GRANT USAGE ON SCHEMA public TO read_only_role;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_only_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO read_only_role;

CREATE USER eduard WITH PASSWORD 'eduard123';
CREATE USER süleyman WITH PASSWORD 'süleyman123';
CREATE USER nikolay WITH PASSWORD 'nikolay123';
CREATE USER mrd WITH PASSWORD 'mrd42';

GRANT read_only_role TO eduard;
GRANT read_only_role TO süleyman;
GRANT read_only_role TO nikolay;
GRANT read_only_role TO mrd;




SELECT *
FROM pg_roles;