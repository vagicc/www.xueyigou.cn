-- 首页轮播图
CREATE TABLE "public"."banners" (
  "id" int4 PRIMARY KEY,
  "banner_name" varchar(50) DEFAULT NULL,
  "image_url" varchar(255) DEFAULT NULL NOT NULL,
  "hyperlink" varchar(255) DEFAULT NULL,
  "is_enabled" bool NOT NULL
);
COMMENT ON COLUMN "public"."banners"."id" IS '首页轮播图ID';
COMMENT ON COLUMN "public"."banners"."banner_name" IS '首页轮播图名称';
COMMENT ON COLUMN "public"."banners"."image_url" IS '首页轮播图URL';
COMMENT ON COLUMN "public"."banners"."hyperlink" IS '超链接';
COMMENT ON COLUMN "public"."banners"."is_enabled" IS '是否启用';

-- ----------------------------
-- Records of banners
-- ----------------------------
INSERT INTO "public"."banners" VALUES (1, '1', 'images/u_banner.jpg', '#', 't');
INSERT INTO "public"."banners" VALUES (2, '2', 'images/u_banner.jpg', 'https://www.baidu.com/', 't');
