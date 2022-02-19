-- Your SQL goes here
CREATE TABLE "public"."customized_services" (
  "id" int8 PRIMARY KEY,
  "cs_name" varchar(50) NOT NULL,
  "hour_wage" float4 NOT NULL,
  "day_wage" float4 NOT NULL,
  "month_wage" float4 NOT NULL,
  "label" varchar(255) DEFAULT NULL,
  "image_url" varchar(255) NOT NULL,
  "is_enabled" bool NOT NULL
);

COMMENT ON COLUMN "public"."customized_services"."id" IS '定制服务id';
COMMENT ON COLUMN "public"."customized_services"."cs_name" IS '定制服务名称';
COMMENT ON COLUMN "public"."customized_services"."hour_wage" IS '时薪';
COMMENT ON COLUMN "public"."customized_services"."day_wage" IS '日薪';
COMMENT ON COLUMN "public"."customized_services"."month_wage" IS '月薪';
COMMENT ON COLUMN "public"."customized_services"."label" IS '标签，标签键请用英文逗号,分隔';
COMMENT ON COLUMN "public"."customized_services"."image_url" IS '图片url';
COMMENT ON COLUMN "public"."customized_services"."is_enabled" IS '是否启用';