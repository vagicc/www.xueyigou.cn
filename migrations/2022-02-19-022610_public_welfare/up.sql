-- Your SQL goes here
CREATE TABLE "public"."public_welfare" (
  "id" int8 PRIMARY KEY,
  "info_title" varchar(128) NOT NULL,
  "date" date NOT NULL,
  "watch" int4 NOT NULL,
  "image_url" varchar(255) NOT NULL,
  "hyperlink" varchar(255) DEFAULT NULL,
  "is_new" bool,
  "is_enable" bool NOT NULL,
  "welfare_type" int2 NOT NULL
)
;
COMMENT ON COLUMN "public"."public_welfare"."id" IS '公益资讯id';
COMMENT ON COLUMN "public"."public_welfare"."info_title" IS '公益资讯标题';
COMMENT ON COLUMN "public"."public_welfare"."date" IS '公益资讯发布日期';
COMMENT ON COLUMN "public"."public_welfare"."watch" IS '浏览量';
COMMENT ON COLUMN "public"."public_welfare"."image_url" IS '图片url';
COMMENT ON COLUMN "public"."public_welfare"."hyperlink" IS '超链接';
COMMENT ON COLUMN "public"."public_welfare"."is_new" IS '是否为新资讯';
COMMENT ON COLUMN "public"."public_welfare"."is_enable" IS '是否启用';
COMMENT ON COLUMN "public"."public_welfare"."welfare_type" IS '类型：1为公益资讯，2为爱心捐助对象，3为募捐活动';

-- ----------------------------
--  插入public_welfare表测试数据
-- ----------------------------
INSERT INTO "public"."public_welfare" VALUES (2, '这是一次测试', '2022-01-26', 39999, 'https://img2.baidu.com/it/u=2389862743,3599143591&fm=253&fmt=auto&app=120&f=JPEG?w=759&h=500', 'www.baidu.com', 't', 't', 2);
INSERT INTO "public"."public_welfare" VALUES (3, '这是一次测试', '2022-01-26', 39999, 'https://img2.baidu.com/it/u=2389862743,3599143591&fm=253&fmt=auto&app=120&f=JPEG?w=759&h=500', 'www.baidu.com', 't', 't', 3);
INSERT INTO "public"."public_welfare" VALUES (9, '这是一次测试', '2022-01-26', 39999, 'https://img2.baidu.com/it/u=2389862743,3599143591&fm=253&fmt=auto&app=120&f=JPEG?w=759&h=500', 'www.baidu.com', 't', 't', 3);
INSERT INTO "public"."public_welfare" VALUES (10, '这是一次测试', '2022-01-26', 39999, 'https://img2.baidu.com/it/u=2389862743,3599143591&fm=253&fmt=auto&app=120&f=JPEG?w=759&h=500', 'www.baidu.com', 't', 't', 1);
INSERT INTO "public"."public_welfare" VALUES (11, '这是一次测试', '2022-01-26', 39999, 'https://img2.baidu.com/it/u=2389862743,3599143591&fm=253&fmt=auto&app=120&f=JPEG?w=759&h=500', 'www.baidu.com', 't', 't', 2);
INSERT INTO "public"."public_welfare" VALUES (12, '这是一次测试', '2022-01-26', 39999, 'https://img2.baidu.com/it/u=2389862743,3599143591&fm=253&fmt=auto&app=120&f=JPEG?w=759&h=500', 'www.baidu.com', 'f', 't', 3);
INSERT INTO "public"."public_welfare" VALUES (1, '这是一次测试', '2022-01-26', 39999, 'https://img2.baidu.com/it/u=2389862743,3599143591&fm=253&fmt=auto&app=120&f=JPEG?w=759&h=500', 'www.baidu.com', 'f', 't', 1);
INSERT INTO "public"."public_welfare" VALUES (4, '这是一次测试', '2022-01-26', 39999, 'images/u_g1.jpg', 'www.baidu.com', 'f', 't', 1);
INSERT INTO "public"."public_welfare" VALUES (5, '六一全国公益组织联合发声：让这些善良、勇敢、坚韧的孩子们被爱守护！', '2022-01-26', 39999, 'images/u_g1.jpg', 'www.baidu.com', 'f', 't', 2);
INSERT INTO "public"."public_welfare" VALUES (6, '这是一次测试', '2022-01-26', 39999, 'images/u_g1.jpg', 'www.baidu.com', 'f', 't', 3);
INSERT INTO "public"."public_welfare" VALUES (7, '这是一次测试', '2022-01-26', 39999, 'images/u_g1.jpg', 'www.baidu.com', 'f', 't', 1);
INSERT INTO "public"."public_welfare" VALUES (8, '这是一次测试', '2022-01-26', 39999, 'images/u_g1.jpg', 'www.baidu.com', 'f', 't', 2);
