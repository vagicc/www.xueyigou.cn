-- index_works
CREATE TABLE "public"."index_works" (
  "id" int8 PRIMARY KEY,
  "works_title" varchar(128) NOT NULL,  
  "watch" int4 NOT NULL,
  "like" int4 NOT NULL,
  "image_url" varchar(255) NOT NULL,
  "label" varchar(255) DEFAULT NULL,
  "is_enable" bool NOT NULL,
  "work_type" int2 NOT NULL,
  "user_id" int4 NOT NULL
)
;
COMMENT ON COLUMN "public"."index_works"."id" IS '作品id';
COMMENT ON COLUMN "public"."index_works"."works_title" IS '作品标题';
COMMENT ON COLUMN "public"."index_works"."watch" IS '浏览量';
COMMENT ON COLUMN "public"."index_works"."like" IS '点赞量';
COMMENT ON COLUMN "public"."index_works"."image_url" IS '图片url';
COMMENT ON COLUMN "public"."index_works"."label" IS '作品标签';
COMMENT ON COLUMN "public"."index_works"."is_enable" IS '是否启用';
COMMENT ON COLUMN "public"."index_works"."work_type" IS '类型：1为最新发布，2为最热作品，3为官方甄选';
COMMENT ON COLUMN "public"."index_works"."user_id" IS '作品发布用户id';