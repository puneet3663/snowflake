CREATE TABLE "public"."employee_new" (
    id      INTEGER PRIMARY KEY,
    name    VARCHAR(50)
);
ALTER TABLE "public"."employee_new" REPLICA IDENTITY DEFAULT;
GRANT SELECT ON "public"."employee_new" TO openflow_repl_new;
ALTER PUBLICATION openflow_pub_new add TABLE "public"."employee_new";

-----------------------------------------------------------------------------
insert into "public"."employee_new" values(200,'Tim');
