<img width="365" height="226" alt="image" src="https://github.com/user-attachments/assets/6cac76a4-4f26-41bb-b724-135e80dbea4e" />

Openflow Postgres CDC → Snowflake: Troubleshooting Summary & Fix Documentation
Problem
Snowflake Openflow pipeline (Snapshot Load + Incremental Load) showed Out: 0 bytes everywhere despite no visible processor errors — data wasn't reaching the target Snowflake tables, even though source/target connections were reportedly configured.
Root Causes (in order discovered)
There were three independent, layered issues — all needed fixing for the pipeline to work:
1. Postgres REPLICA IDENTITY not set to default

Table customer_new had REPLICA IDENTITY FULL instead of DEFAULT
Even though a valid single-column primary key existed, the connector's validation specifically checks relreplident = 'd' (default/PK-based) — FULL was read as "no usable PK for replication"
Fix:

sql  ALTER TABLE public.customer_new REPLICA IDENTITY DEFAULT;
2. Snowflake key-pair authentication never configured (the big one)

The Snowflake Private Key Service controller service had no private key set: Component is invalid: 'Key' is invalid because Private Key not configured
This is the auth mechanism Openflow uses to write to the target Snowflake account — without it, snapshot reads could happen but writes silently failed
Fix steps:

Generate an RSA key pair locally (never let the private key leave your machine — do not generate it in any shared/remote tool):

PowerShell 5.1 lacks ExportPkcs8PrivateKey() — used Python instead:





python       from cryptography.hazmat.primitives import serialization
       from cryptography.hazmat.primitives.asymmetric import rsa

       key = rsa.generate_private_key(public_exponent=65537, key_size=2048)

       private_pem = key.private_bytes(
           encoding=serialization.Encoding.PEM,
           format=serialization.PrivateFormat.PKCS8,
           encryption_algorithm=serialization.NoEncryption()
       )
       public_pem = key.public_key().public_bytes(
           encoding=serialization.Encoding.PEM,
           format=serialization.PublicFormat.SubjectPublicKeyInfo
       )

       with open("rsa_key.p8", "wb") as f: f.write(private_pem)
       with open("rsa_key.pub", "wb") as f: f.write(public_pem)
   Run via: `python -m pip install cryptography --user` then `python gen_keys.py`
2. Register the public key on the Snowflake service user (strip BEGIN/END header lines, paste only base64 body):
sql     USE ROLE ACCOUNTADMIN;
     ALTER USER OPENFLOW_USER SET RSA_PUBLIC_KEY='<base64 body only>';
     DESC USER OPENFLOW_USER; -- confirm RSA_PUBLIC_KEY_FP is populated

Paste the private key (full PEM block, including -----BEGIN/END PRIVATE KEY----- lines) into Openflow → Controller Services → Snowflake Private Key Service → Properties → Key parameter
Perform Validation → should show Valid
Enable the service, restart dependent processors

3. Stale leftover Snowflake table colliding with fresh create

An earlier failed/partial run had left an empty customer_new table sitting in the target Snowflake schema
New replication attempts tried to create the table again and hit a conflict: state store showed FAILED, SNOWFLAKE_OBJECT_ALREADY_EXISTS
Fix:

sql  USE ROLE OPENFLOW_ROLE; -- or ACCOUNTADMIN if needed
  DROP TABLE IF EXISTS PG_CDC_POC.public.customer_new;
Key Diagnostic Techniques Learned
TechniqueWherePurposeCheck In/Out/Read-write byte counts on each processor boxCanvasPinpoint exactly which stage drops data (0 bytes out = dead end)Bulletin Board (flag/bell icon, top toolbar)GlobalSee ALL errors/warnings across the entire flow, not just one processorBulletin dot on individual processorHover bottom-right corner of processor boxComponent-specific error detailView State on a Controller Service (not the processor)Controller Services list → ⋮ menuSome connectors store table tracking state in a controller service, not processor state — shows key/value/status per tableRelationships tab on a processorRight-click → View configurationCheck which relationships are auto-terminated vs. routed — silently dropped data often means a relationship is terminated when it shouldn't be
Useful Diagnostic SQL (Postgres side)
sql-- Check primary key
SELECT tc.table_name, kcu.column_name, count(*) 
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu ON tc.constraint_name = kcu.constraint_name
WHERE tc.constraint_type='PRIMARY KEY' AND tc.table_name='<table>'
GROUP BY tc.table_name, kcu.column_name;

-- Check replica identity (should be 'd')
SELECT relname, relreplident FROM pg_class WHERE relname = '<table>';

-- Check publication membership
SELECT pubname, schemaname, tablename FROM pg_publication_tables ORDER BY pubname;

-- Check replication slot status
SELECT slot_name, plugin, slot_type, active FROM pg_replication_slots;
SELECT * FROM pg_stat_replication;
Cleanup To-Do (post-fix)

 Remove unused duplicate publications (openflow_pub, openflow_pub1 if redundant) and orphaned slots (test_slot_customer_new if unused) — unused slots retain WAL and bloat disk over time
 Confirm only one canonical publication/slot pair is in active use
 Document the final working Publication Name + Slot Name + Snowflake service user (OPENFLOW_USER) for future reference
 Verify customer and customer1 don't have similar stale-table issues if you rebuild this later
Want to be notified when Claude responds?Notify
Sonnet 4.6 Low
