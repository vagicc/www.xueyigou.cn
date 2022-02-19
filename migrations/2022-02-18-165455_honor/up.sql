-- honor
CREATE TABLE "public"."honor" (
  "id" int8 PRIMARY KEY,
  "honor_name" varchar(64) NOT NULL,
  "detail" varchar(255) DEFAULT NULL,
  "image_url" varchar(255) NOT NULL,
  "hyper_url" varchar(255) DEFAULT NULL,
  "is_enabled" bool NOT NULL
)
;
COMMENT ON COLUMN "public"."honor"."id" IS '荣誉id';
COMMENT ON COLUMN "public"."honor"."honor_name" IS '荣誉标题';
COMMENT ON COLUMN "public"."honor"."detail" IS '荣誉详情：数字与中文之间以英文点.分隔，两个荣誉之间以英文逗号,分隔';
COMMENT ON COLUMN "public"."honor"."image_url" IS '荣誉图片';
COMMENT ON COLUMN "public"."honor"."hyper_url" IS '超链接';
COMMENT ON COLUMN "public"."honor"."is_enabled" IS '是否启用';