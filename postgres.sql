CREATE TABLE "public"."employee" (
    id      INTEGER PRIMARY KEY,
    name    VARCHAR(50)
);

ALTER TABLE "public"."employee" REPLICA IDENTITY DEFAULT;
--ALTER TABLE "public"."employee" REPLICA IDENTITY FULL;

--validation
SELECT 
  t.relname AS table_name,
  CASE WHEN c.contype = 'p' THEN 'Has Primary Key' ELSE 'NO PRIMARY KEY' END AS pk_status,
  t.relreplident AS replica_identity   -- expect: 'd' (default)
FROM pg_class t
LEFT JOIN pg_constraint c ON c.conrelid = t.oid AND c.contype = 'p'
WHERE t.relname = 'employee';

CREATE USER openflow_repl_new WITH REPLICATION PASSWORD '*******';

GRANT CONNECT ON DATABASE "postgres" TO openflow_repl_new;
GRANT USAGE ON SCHEMA "public" TO openflow_repl_new;
GRANT SELECT ON ALL TABLES IN SCHEMA "public" TO openflow_repl_new;
GRANT SELECT ON "public"."employee" TO openflow_repl_new;
ALTER DEFAULT PRIVILEGES IN SCHEMA "public" GRANT SELECT ON TABLES TO openflow_repl_new;
GRANT ALL PRIVILEGES ON DATABASE "postgres" TO snowflake_admin;




--CREATE PUBLICATION openflow_pub_new FOR TABLE "public"."employee";

ALTER PUBLICATION openflow_pub_new add TABLE "public"."employee";

SHOW wal_level; --logical
SHOW max_replication_slots; --10
SHOW max_wal_senders; --10

--important
SELECT pg_create_logical_replication_slot('test_slot_customer_new', 'pgoutput');

SELECT relname, relreplident
FROM pg_class
WHERE relname = 'employee';


SELECT grantee, table_name, privilege_type 
FROM information_schema.table_privileges 
WHERE grantee = 'openflow_repl_new' AND table_name = 'employee';

SELECT * FROM pg_replication_slots;

SELECT * FROM pg_publication_tables WHERE pubname = 'openflow_pub_new' AND tablename = 'employee';




insert into "public"."employee" values(200,'Tim');
delete from "public"."employee";
insert into public.employee values(198,'Shannon');






/*Snowflake SQLs
GRANT USAGE ON DATABASE postgres TO ROLE OPENFLOW_ROLE;
select * from postgres.public.customer_new
USE ROLE ACCOUNTADMIN;
GRANT USAGE ON DATABASE "postgres" TO ROLE OPENFLOW_ROLE;
GRANT USAGE ON SCHEMA "postgres".public TO ROLE OPENFLOW_ROLE;
GRANT SELECT ON TABLE "postgres".public.customer_new TO ROLE OPENFLOW_ROLE;
*/


SELECT count(*) FROM public.customer_new WHERE id IS NULL;

SELECT grantee, privilege_type 
FROM information_schema.table_privileges 
WHERE table_schema = 'public' AND table_name = 'customer_new_26';

SELECT schemaname, tablename 
FROM pg_publication_tables 
WHERE tablename = 'customer_new';

SELECT pubname, schemaname, tablename 
FROM pg_publication_tables 
ORDER BY pubname, tablename;

SELECT slot_name, plugin, slot_type, database, active
FROM pg_replication_slots;

SELECT * FROM pg_stat_replication;

SELECT schemaname, tablename 
FROM pg_tables 
WHERE schemaname = 'public';




--------------------------------------------------------------------------------------------------
--old Backup

 select * from "public"."customer_new_27";
 
CREATE TABLE "public"."customer_new_27" AS SELECT * FROM public.customer_new;

insert into public.customer_new values(200,'Shannon');
insert into public.customer_new_26 values(18,'Tim');

delete from "public"."customer_new"
ALTER TABLE public.customer_new ADD column pincode varchar(50);

select * from public.customer_new_26 


