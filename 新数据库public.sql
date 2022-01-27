/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : PostgreSQL
 Source Server Version : 140000
 Source Host           : 192.168.31.111:5432
 Source Catalog        : warpwiki
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 140000
 File Encoding         : 65001

 Date: 27/01/2022 11:01:29
*/


-- ----------------------------
-- Type structure for goods_description_type
-- ----------------------------
DROP TYPE IF EXISTS "public"."goods_description_type";
CREATE TYPE "public"."goods_description_type" AS ENUM (
  'PC',
  'H5',
  'APP'
);
ALTER TYPE "public"."goods_description_type" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for admins_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."admins_id_seq";
CREATE SEQUENCE "public"."admins_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for banners_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."banners_id_seq";
CREATE SEQUENCE "public"."banners_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for customized_services_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."customized_services_id_seq";
CREATE SEQUENCE "public"."customized_services_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for goods_category_cid_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."goods_category_cid_seq";
CREATE SEQUENCE "public"."goods_category_cid_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for goods_description_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."goods_description_id_seq";
CREATE SEQUENCE "public"."goods_description_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for goods_detail_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."goods_detail_id_seq";
CREATE SEQUENCE "public"."goods_detail_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for goods_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."goods_id_seq";
CREATE SEQUENCE "public"."goods_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for goods_photo_pid_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."goods_photo_pid_seq";
CREATE SEQUENCE "public"."goods_photo_pid_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for honor_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."honor_id_seq";
CREATE SEQUENCE "public"."honor_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for index_works_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."index_works_id_seq";
CREATE SEQUENCE "public"."index_works_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for linksnap_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."linksnap_id_seq";
CREATE SEQUENCE "public"."linksnap_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for public_welfare_info_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."public_welfare_info_id_seq";
CREATE SEQUENCE "public"."public_welfare_info_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sessions_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sessions_id_seq";
CREATE SEQUENCE "public"."sessions_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for to_approve_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."to_approve_id_seq";
CREATE SEQUENCE "public"."to_approve_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_id_seq";
CREATE SEQUENCE "public"."users_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for __diesel_schema_migrations
-- ----------------------------
DROP TABLE IF EXISTS "public"."__diesel_schema_migrations";
CREATE TABLE "public"."__diesel_schema_migrations" (
  "version" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "run_on" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of __diesel_schema_migrations
-- ----------------------------
INSERT INTO "public"."__diesel_schema_migrations" VALUES ('00000000000000', '2022-01-26 18:49:02.793478');
INSERT INTO "public"."__diesel_schema_migrations" VALUES ('20210513071702', '2022-01-26 18:49:02.934517');
INSERT INTO "public"."__diesel_schema_migrations" VALUES ('20210514135214', '2022-01-26 18:49:03.082314');
INSERT INTO "public"."__diesel_schema_migrations" VALUES ('20210516122122', '2022-01-26 18:49:03.220788');
INSERT INTO "public"."__diesel_schema_migrations" VALUES ('20211102085453', '2022-01-26 18:49:03.371508');
INSERT INTO "public"."__diesel_schema_migrations" VALUES ('20211120123715', '2022-01-26 18:49:03.525071');

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS "public"."admins";
CREATE TABLE "public"."admins" (
  "id" int4 NOT NULL DEFAULT nextval('admins_id_seq'::regclass),
  "username" varchar(16) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "salt" char(10) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "mobile" char(11) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "role" int2,
  "status" int8 DEFAULT 0,
  "create_time" timestamp(6) DEFAULT clock_timestamp(),
  "last_login" timestamp(6)
)
;
COMMENT ON COLUMN "public"."admins"."id" IS '自增主键ID';
COMMENT ON COLUMN "public"."admins"."username" IS '登录名';
COMMENT ON COLUMN "public"."admins"."password" IS '登录密码';
COMMENT ON COLUMN "public"."admins"."salt" IS '混淆码';
COMMENT ON COLUMN "public"."admins"."email" IS '邮箱';
COMMENT ON COLUMN "public"."admins"."mobile" IS '电话';
COMMENT ON COLUMN "public"."admins"."role" IS '角色组ID';
COMMENT ON COLUMN "public"."admins"."status" IS '是否冻结：0=正常，1=永久冻结，冻结时间';
COMMENT ON COLUMN "public"."admins"."create_time" IS '创建时间(不带时区)';
COMMENT ON COLUMN "public"."admins"."last_login" IS '最后登录时间(不带时区)';
COMMENT ON TABLE "public"."admins" IS '后台管理角色组';

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO "public"."admins" VALUES (1, 'luck', 'c2a3b691ee173bbaee19a5d6aae8c995507fa706', '25ee364a54', 'luck@fmail.pro', '13428122341', 1, 0, '2008-08-18 18:58:13', '2018-08-18 18:58:18');

-- ----------------------------
-- Table structure for banners
-- ----------------------------
DROP TABLE IF EXISTS "public"."banners";
CREATE TABLE "public"."banners" (
  "id" int4 NOT NULL DEFAULT nextval('banners_id_seq'::regclass),
  "banner_name" varchar(50) COLLATE "pg_catalog"."default",
  "image_url" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "hyperlink" varchar(255) COLLATE "pg_catalog"."default",
  "is_enabled" bool NOT NULL
)
;
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

-- ----------------------------
-- Table structure for customized_services
-- ----------------------------
DROP TABLE IF EXISTS "public"."customized_services";
CREATE TABLE "public"."customized_services" (
  "id" int8 NOT NULL DEFAULT nextval('customized_services_id_seq'::regclass),
  "cs_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "hour_wage" float4 NOT NULL,
  "day_wage" float4 NOT NULL,
  "month_wage" float4 NOT NULL,
  "label" varchar(255) COLLATE "pg_catalog"."default",
  "image_url" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "is_enabled" bool NOT NULL
)
;
COMMENT ON COLUMN "public"."customized_services"."id" IS '定制服务id';
COMMENT ON COLUMN "public"."customized_services"."cs_name" IS '定制服务名称';
COMMENT ON COLUMN "public"."customized_services"."hour_wage" IS '时薪';
COMMENT ON COLUMN "public"."customized_services"."day_wage" IS '日薪';
COMMENT ON COLUMN "public"."customized_services"."month_wage" IS '月薪';
COMMENT ON COLUMN "public"."customized_services"."label" IS '标签，标签键请用英文逗号,分隔';
COMMENT ON COLUMN "public"."customized_services"."image_url" IS '图片url';
COMMENT ON COLUMN "public"."customized_services"."is_enabled" IS '是否启用';

-- ----------------------------
-- Records of customized_services
-- ----------------------------
INSERT INTO "public"."customized_services" VALUES (2, '测试', 52.68, 25.38, 35.45, '测试', 'images/u_s1.jpg', 't');
INSERT INTO "public"."customized_services" VALUES (3, '测试', 52.68, 25.38, 35.45, '测试', 'images/u_s1.jpg', 't');
INSERT INTO "public"."customized_services" VALUES (5, '测试', 52.68, 25.38, 35.45, '测试', 'images/u_s1.jpg', 't');
INSERT INTO "public"."customized_services" VALUES (6, '测试', 52.68, 25.38, 35.45, '测试', 'images/u_s1.jpg', 't');
INSERT INTO "public"."customized_services" VALUES (4, '测试', 52.68, 25.38, 35.45, '测试', 'https://img1.baidu.com/it/u=3789058185,1808652640&fm=253&fmt=auto&app=120&f=JPEG?', 't');
INSERT INTO "public"."customized_services" VALUES (1, '测试', 52.68, 25.38, 35.45, '测试,喵喵喵,res', 'https://img1.baidu.com/it/u=3789058185,1808652640&fm=253&fmt=auto&app=120&f=JPEG?w=750&h=500', 't');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS "public"."goods";
CREATE TABLE "public"."goods" (
  "id" int4 NOT NULL DEFAULT nextval('goods_id_seq'::regclass),
  "cid" int4,
  "goods_name" varchar(80) COLLATE "pg_catalog"."default" NOT NULL,
  "goods_sn" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "cost_price" money NOT NULL DEFAULT 0,
  "market_price" money NOT NULL DEFAULT 0,
  "sell_price" money NOT NULL DEFAULT 0,
  "donate_proportion" numeric(4,2) NOT NULL DEFAULT 0.00,
  "sku" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "inventory" int4 NOT NULL DEFAULT 0,
  "goods_img" varchar(255) COLLATE "pg_catalog"."default",
  "enabled" bool DEFAULT true,
  "is_virtual" bool DEFAULT false,
  "search_words" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "visit" int8 NOT NULL DEFAULT 0,
  "sale" int4 NOT NULL DEFAULT 0,
  "comments" int8 NOT NULL DEFAULT 0,
  "grade" int2 NOT NULL DEFAULT 0,
  "up_time" timestamp(6),
  "down_time" timestamp(6),
  "create_id" int4,
  "create_time" timestamp(6) DEFAULT clock_timestamp()
)
;
COMMENT ON COLUMN "public"."goods"."id" IS '商品ID';
COMMENT ON COLUMN "public"."goods"."cid" IS '商品分类ID';
COMMENT ON COLUMN "public"."goods"."goods_name" IS '商品名称';
COMMENT ON COLUMN "public"."goods"."goods_sn" IS '商品货号';
COMMENT ON COLUMN "public"."goods"."cost_price" IS '成本价';
COMMENT ON COLUMN "public"."goods"."market_price" IS '市场价';
COMMENT ON COLUMN "public"."goods"."sell_price" IS '销售价';
COMMENT ON COLUMN "public"."goods"."donate_proportion" IS '捐赠比例：0为不捐赠、12.1为12.1%';
COMMENT ON COLUMN "public"."goods"."sku" IS '计件单位:件,箱,个,包，……';
COMMENT ON COLUMN "public"."goods"."inventory" IS '库存';
COMMENT ON COLUMN "public"."goods"."goods_img" IS '封面图(176*255)-列表显示的图片(外框width:201px;height:275px;)';
COMMENT ON COLUMN "public"."goods"."enabled" IS '是否在售：false为下架，true在售，unknown预定';
COMMENT ON COLUMN "public"."goods"."is_virtual" IS '是否为虚拟商品：false为实体商品（需要快递），true为虚拟商品（发货不需要快递）';
COMMENT ON COLUMN "public"."goods"."search_words" IS '商品搜索词库,逗号分隔';
COMMENT ON COLUMN "public"."goods"."visit" IS '浏览次数';
COMMENT ON COLUMN "public"."goods"."sale" IS '销量';
COMMENT ON COLUMN "public"."goods"."comments" IS '评论次数';
COMMENT ON COLUMN "public"."goods"."grade" IS '评分总数';
COMMENT ON COLUMN "public"."goods"."up_time" IS '上架时间';
COMMENT ON COLUMN "public"."goods"."down_time" IS '下架时间';
COMMENT ON COLUMN "public"."goods"."create_id" IS '上传者ID';
COMMENT ON COLUMN "public"."goods"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."goods" IS '商品表';

-- ----------------------------
-- Records of goods
-- ----------------------------

-- ----------------------------
-- Table structure for goods_category
-- ----------------------------
DROP TABLE IF EXISTS "public"."goods_category";
CREATE TABLE "public"."goods_category" (
  "cid" int4 NOT NULL DEFAULT nextval('goods_category_cid_seq'::regclass),
  "cname" varchar(50) COLLATE "pg_catalog"."default",
  "parent_id" int4 NOT NULL DEFAULT 0,
  "level" int2 NOT NULL DEFAULT 1,
  "seo_title" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "seo_keywords" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "seo_description" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "order_by" int2 NOT NULL,
  "is_show" bool DEFAULT true,
  "modify_id" int4,
  "modify_time" timestamp(6),
  "create_id" int4,
  "create_time" timestamp(6) DEFAULT clock_timestamp()
)
;
COMMENT ON COLUMN "public"."goods_category"."cid" IS '商品分类ID';
COMMENT ON COLUMN "public"."goods_category"."cname" IS '分类名称';
COMMENT ON COLUMN "public"."goods_category"."parent_id" IS '父分类ID';
COMMENT ON COLUMN "public"."goods_category"."level" IS '类别层级';
COMMENT ON COLUMN "public"."goods_category"."seo_title" IS 'SEO标题';
COMMENT ON COLUMN "public"."goods_category"."seo_keywords" IS 'SEO关键词';
COMMENT ON COLUMN "public"."goods_category"."seo_description" IS 'SEO描述';
COMMENT ON COLUMN "public"."goods_category"."order_by" IS '排序:小排前，大排后';
COMMENT ON COLUMN "public"."goods_category"."is_show" IS '是否显示：默认true显示，flase不显示';
COMMENT ON COLUMN "public"."goods_category"."modify_id" IS '最后修改者ID';
COMMENT ON COLUMN "public"."goods_category"."modify_time" IS '最后修改者时间';
COMMENT ON COLUMN "public"."goods_category"."create_id" IS '创建者ID';
COMMENT ON COLUMN "public"."goods_category"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."goods_category" IS '商品分类表';

-- ----------------------------
-- Records of goods_category
-- ----------------------------

-- ----------------------------
-- Table structure for goods_description
-- ----------------------------
DROP TABLE IF EXISTS "public"."goods_description";
CREATE TABLE "public"."goods_description" (
  "id" int4 NOT NULL DEFAULT nextval('goods_description_id_seq'::regclass),
  "goods_id" int4 NOT NULL,
  "type" "public"."goods_description_type" DEFAULT 'PC'::goods_description_type,
  "description" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."goods_description"."goods_id" IS '商品ID';
COMMENT ON COLUMN "public"."goods_description"."type" IS '商品详情类型：PC、H5、APP';
COMMENT ON COLUMN "public"."goods_description"."description" IS '商品详情描述';

-- ----------------------------
-- Records of goods_description
-- ----------------------------

-- ----------------------------
-- Table structure for goods_detail
-- ----------------------------
DROP TABLE IF EXISTS "public"."goods_detail";
CREATE TABLE "public"."goods_detail" (
  "id" int4 NOT NULL DEFAULT nextval('goods_detail_id_seq'::regclass),
  "goods_id" int4 NOT NULL,
  "weight" numeric(15,2) NOT NULL DEFAULT 0.00,
  "size" varchar(80) COLLATE "pg_catalog"."default",
  "color" varchar(80) COLLATE "pg_catalog"."default",
  "excerpt" text COLLATE "pg_catalog"."default",
  "free_shipping" bool DEFAULT true,
  "seo_title" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "seo_keywords" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "seo_description" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "modify_id" int4,
  "modify_time" timestamp(6) DEFAULT clock_timestamp()
)
;
COMMENT ON COLUMN "public"."goods_detail"."weight" IS '重量kg';
COMMENT ON COLUMN "public"."goods_detail"."size" IS '大小尺寸';
COMMENT ON COLUMN "public"."goods_detail"."color" IS '颜色';
COMMENT ON COLUMN "public"."goods_detail"."excerpt" IS '商品摘要:规格与包装';
COMMENT ON COLUMN "public"."goods_detail"."free_shipping" IS '是否免运费,默认免运费true';
COMMENT ON COLUMN "public"."goods_detail"."seo_title" IS 'SEO标题';
COMMENT ON COLUMN "public"."goods_detail"."seo_keywords" IS 'SEO关键词';
COMMENT ON COLUMN "public"."goods_detail"."seo_description" IS 'SEO描述';
COMMENT ON COLUMN "public"."goods_detail"."modify_id" IS '最后修改者ID';
COMMENT ON COLUMN "public"."goods_detail"."modify_time" IS '修改时间';
COMMENT ON TABLE "public"."goods_detail" IS '商品详情表';

-- ----------------------------
-- Records of goods_detail
-- ----------------------------

-- ----------------------------
-- Table structure for goods_photo
-- ----------------------------
DROP TABLE IF EXISTS "public"."goods_photo";
CREATE TABLE "public"."goods_photo" (
  "pid" int4 NOT NULL DEFAULT nextval('goods_photo_pid_seq'::regclass),
  "goods_id" int4 NOT NULL,
  "small" varchar(255) COLLATE "pg_catalog"."default",
  "middle" varchar(255) COLLATE "pg_catalog"."default",
  "original" varchar(255) COLLATE "pg_catalog"."default",
  "path" varchar(255) COLLATE "pg_catalog"."default",
  "title" varchar(58) COLLATE "pg_catalog"."default",
  "extension" varchar(8) COLLATE "pg_catalog"."default",
  "type" varchar(18) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) DEFAULT clock_timestamp()
)
;
COMMENT ON COLUMN "public"."goods_photo"."goods_id" IS '商品ID';
COMMENT ON COLUMN "public"."goods_photo"."small" IS '小图(100*47)';
COMMENT ON COLUMN "public"."goods_photo"."middle" IS '中图(289*318)';
COMMENT ON COLUMN "public"."goods_photo"."original" IS '原图(578*637)';
COMMENT ON COLUMN "public"."goods_photo"."path" IS '图片路径';
COMMENT ON COLUMN "public"."goods_photo"."title" IS '图片名不带扩展';
COMMENT ON COLUMN "public"."goods_photo"."extension" IS '图片扩展名如：jpg';
COMMENT ON COLUMN "public"."goods_photo"."type" IS '图片类型如：image/jpeg';
COMMENT ON TABLE "public"."goods_photo" IS '商品相册表';

-- ----------------------------
-- Records of goods_photo
-- ----------------------------

-- ----------------------------
-- Table structure for honor
-- ----------------------------
DROP TABLE IF EXISTS "public"."honor";
CREATE TABLE "public"."honor" (
  "id" int8 NOT NULL DEFAULT nextval('honor_id_seq'::regclass),
  "honor_name" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "detail" varchar(255) COLLATE "pg_catalog"."default",
  "image_url" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "hyper_url" varchar(255) COLLATE "pg_catalog"."default",
  "is_enabled" bool NOT NULL
)
;
COMMENT ON COLUMN "public"."honor"."id" IS '荣誉id';
COMMENT ON COLUMN "public"."honor"."honor_name" IS '荣誉标题';
COMMENT ON COLUMN "public"."honor"."detail" IS '荣誉详情：数字与中文之间以英文点.分隔，两个荣誉之间以英文逗号,分隔';
COMMENT ON COLUMN "public"."honor"."image_url" IS '荣誉图片';
COMMENT ON COLUMN "public"."honor"."hyper_url" IS '超链接';
COMMENT ON COLUMN "public"."honor"."is_enabled" IS '是否启用';

-- ----------------------------
-- Records of honor
-- ----------------------------
INSERT INTO "public"."honor" VALUES (2, '这也是一个测试', '测试', 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.ivsky.com%2Fimg%2Fbizhi%2Fpre%2F201205%2F01%2Fkeai_maomi-009.jpg&refer=http%3A%2F%2Fimg.ivsky.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1645838021&t=02d6e22760e0893b884f611411e5f5d4', 'www.baidu.com', 't');
INSERT INTO "public"."honor" VALUES (3, '这也是一个测试', '测试', 'images/u_user_01.png', 'www.baidu.com', 't');
INSERT INTO "public"."honor" VALUES (5, '这也是一个测试', '测试', 'images/u_user_01.png', 'www.baidu.com', 't');
INSERT INTO "public"."honor" VALUES (6, '这也是一个测试', '测试', 'images/u_user_01.png', 'www.baidu.com', 't');
INSERT INTO "public"."honor" VALUES (4, '这也是一个测试', '12.枚学艺购奖章,2885.公益贡献值', 'images/u_user_01.png', 'www.baidu.com', 't');
INSERT INTO "public"."honor" VALUES (1, '这也是一个测试', '1.枚学艺购奖章,85.公益贡献值', 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.ivsky.com%2Fimg%2Fbizhi%2Fpre%2F201205%2F01%2Fkeai_maomi-009.jpg&refer=http%3A%2F%2Fimg.ivsky.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1645838021&t=02d6e22760e0893b884f611411e5f5d4', 'www.baidu.com', 't');

-- ----------------------------
-- Table structure for index_works
-- ----------------------------
DROP TABLE IF EXISTS "public"."index_works";
CREATE TABLE "public"."index_works" (
  "id" int8 NOT NULL DEFAULT nextval('index_works_id_seq'::regclass),
  "works_title" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "watch" int4 NOT NULL,
  "like" int4 NOT NULL,
  "image_url" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "label" varchar(255) COLLATE "pg_catalog"."default",
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

-- ----------------------------
-- Records of index_works
-- ----------------------------
INSERT INTO "public"."index_works" VALUES (1, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 1, 1);
INSERT INTO "public"."index_works" VALUES (2, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 1, 1);
INSERT INTO "public"."index_works" VALUES (3, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 1, 1);
INSERT INTO "public"."index_works" VALUES (4, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 1, 1);
INSERT INTO "public"."index_works" VALUES (5, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 1, 1);
INSERT INTO "public"."index_works" VALUES (6, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 1, 1);
INSERT INTO "public"."index_works" VALUES (7, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 1, 1);
INSERT INTO "public"."index_works" VALUES (8, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 1, 1);
INSERT INTO "public"."index_works" VALUES (9, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 1, 1);
INSERT INTO "public"."index_works" VALUES (10, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 1, 1);
INSERT INTO "public"."index_works" VALUES (11, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 2, 1);
INSERT INTO "public"."index_works" VALUES (12, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 2, 1);
INSERT INTO "public"."index_works" VALUES (13, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 2, 1);
INSERT INTO "public"."index_works" VALUES (14, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 2, 1);
INSERT INTO "public"."index_works" VALUES (15, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 2, 1);
INSERT INTO "public"."index_works" VALUES (16, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 2, 1);
INSERT INTO "public"."index_works" VALUES (17, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 2, 1);
INSERT INTO "public"."index_works" VALUES (18, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 2, 1);
INSERT INTO "public"."index_works" VALUES (19, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 2, 1);
INSERT INTO "public"."index_works" VALUES (21, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 3, 1);
INSERT INTO "public"."index_works" VALUES (22, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 3, 1);
INSERT INTO "public"."index_works" VALUES (23, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 3, 1);
INSERT INTO "public"."index_works" VALUES (24, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 3, 1);
INSERT INTO "public"."index_works" VALUES (26, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 3, 1);
INSERT INTO "public"."index_works" VALUES (27, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 3, 1);
INSERT INTO "public"."index_works" VALUES (28, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 3, 1);
INSERT INTO "public"."index_works" VALUES (29, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 3, 1);
INSERT INTO "public"."index_works" VALUES (20, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 2, 1);
INSERT INTO "public"."index_works" VALUES (30, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 3, 1);
INSERT INTO "public"."index_works" VALUES (31, '嘻螺会·浓汤螺蛳粉', 6466, 996, 'images/u_w1.jpg', '工学', 't', 3, 1);

-- ----------------------------
-- Table structure for linksnap
-- ----------------------------
DROP TABLE IF EXISTS "public"."linksnap";
CREATE TABLE "public"."linksnap" (
  "id" int4 NOT NULL DEFAULT nextval('linksnap_id_seq'::regclass),
  "title" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "url" text COLLATE "pg_catalog"."default" NOT NULL,
  "added" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of linksnap
-- ----------------------------

-- ----------------------------
-- Table structure for public_welfare
-- ----------------------------
DROP TABLE IF EXISTS "public"."public_welfare";
CREATE TABLE "public"."public_welfare" (
  "id" int8 NOT NULL DEFAULT nextval('public_welfare_info_id_seq'::regclass),
  "info_title" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "date" date NOT NULL,
  "watch" int4 NOT NULL,
  "image_url" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "hyperlink" varchar(255) COLLATE "pg_catalog"."default",
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
-- Records of public_welfare
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

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS "public"."sessions";
CREATE TABLE "public"."sessions" (
  "id" int4 NOT NULL DEFAULT nextval('sessions_id_seq'::regclass),
  "cookie" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" int4 NOT NULL
)
;

-- ----------------------------
-- Records of sessions
-- ----------------------------

-- ----------------------------
-- Table structure for to_approve
-- ----------------------------
DROP TABLE IF EXISTS "public"."to_approve";
CREATE TABLE "public"."to_approve" (
  "id" int4 NOT NULL DEFAULT nextval('to_approve_id_seq'::regclass),
  "mobile" char(11) COLLATE "pg_catalog"."default" NOT NULL,
  "real_name" varchar(120) COLLATE "pg_catalog"."default" NOT NULL,
  "is_student" bool DEFAULT false,
  "student_certificate" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "identity_card" char(18) COLLATE "pg_catalog"."default" NOT NULL,
  "identity_card_frontage" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "identity_card_verso" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "alipay" varchar(120) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "figure" money,
  "credit_code" char(18) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "business_license" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "status" int2 NOT NULL DEFAULT 0,
  "user_id" int4 NOT NULL,
  "user_type" int2 NOT NULL,
  "modify_id" int4,
  "modify_time" timestamp(6),
  "add_time" timestamp(6) DEFAULT clock_timestamp()
)
;
COMMENT ON COLUMN "public"."to_approve"."id" IS 'ID';
COMMENT ON COLUMN "public"."to_approve"."mobile" IS '本人实名认证手机号';
COMMENT ON COLUMN "public"."to_approve"."real_name" IS '用户真实名称';
COMMENT ON COLUMN "public"."to_approve"."is_student" IS '是否是学生';
COMMENT ON COLUMN "public"."to_approve"."student_certificate" IS '学生证';
COMMENT ON COLUMN "public"."to_approve"."identity_card" IS '身份证号码';
COMMENT ON COLUMN "public"."to_approve"."identity_card_frontage" IS '身份证正面照片';
COMMENT ON COLUMN "public"."to_approve"."identity_card_verso" IS '身份证反面照片';
COMMENT ON COLUMN "public"."to_approve"."alipay" IS '支付宝账号';
COMMENT ON COLUMN "public"."to_approve"."figure" IS '支付宝认证金额';
COMMENT ON COLUMN "public"."to_approve"."credit_code" IS '社会信用代码';
COMMENT ON COLUMN "public"."to_approve"."business_license" IS '营业执照照片';
COMMENT ON COLUMN "public"."to_approve"."status" IS '状态：0默认待审核，-1审核不通过，1审核通过';
COMMENT ON COLUMN "public"."to_approve"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."to_approve"."user_type" IS '用户类型：1普通用户；2设计师用户；3企业用户';
COMMENT ON COLUMN "public"."to_approve"."modify_id" IS '后台审核修改ID';
COMMENT ON COLUMN "public"."to_approve"."modify_time" IS '修改时间';
COMMENT ON COLUMN "public"."to_approve"."add_time" IS '添加时间';
COMMENT ON TABLE "public"."to_approve" IS '资质申请表';

-- ----------------------------
-- Records of to_approve
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
  "id" int4 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
  "email" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "mobile" char(11) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "username" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "realname" varchar COLLATE "pg_catalog"."default",
  "user_type" int2 NOT NULL DEFAULT 1,
  "password" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "salt" char(10) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "create_time" timestamp(6) DEFAULT clock_timestamp(),
  "last_login" timestamp(6) DEFAULT clock_timestamp(),
  "avatar" varchar(100) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."users"."email" IS '邮箱';
COMMENT ON COLUMN "public"."users"."mobile" IS '手机号码';
COMMENT ON COLUMN "public"."users"."username" IS '会员名';
COMMENT ON COLUMN "public"."users"."realname" IS '真实姓名';
COMMENT ON COLUMN "public"."users"."user_type" IS '用户类型：1普通用户；2设计师用户；3企业用户';
COMMENT ON COLUMN "public"."users"."avatar" IS '头像';
COMMENT ON TABLE "public"."users" IS '客户（会员）信息表';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO "public"."users" VALUES (1, 'user@example.com', '1000       ', '大学生王', '111', 1, '111', '&         ', '2022-01-27 03:59:05', '2022-01-27 03:59:08', 'images/u_user_01.png');

-- ----------------------------
-- Function structure for diesel_manage_updated_at
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."diesel_manage_updated_at"("_tbl" regclass);
CREATE OR REPLACE FUNCTION "public"."diesel_manage_updated_at"("_tbl" regclass)
  RETURNS "pg_catalog"."void" AS $BODY$
BEGIN
    EXECUTE format('CREATE TRIGGER set_updated_at BEFORE UPDATE ON %s
                    FOR EACH ROW EXECUTE PROCEDURE diesel_set_updated_at()', _tbl);
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for diesel_set_updated_at
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."diesel_set_updated_at"();
CREATE OR REPLACE FUNCTION "public"."diesel_set_updated_at"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
    IF (
        NEW IS DISTINCT FROM OLD AND
        NEW.updated_at IS NOT DISTINCT FROM OLD.updated_at
    ) THEN
        NEW.updated_at := current_timestamp;
    END IF;
    RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."admins_id_seq"
OWNED BY "public"."admins"."id";
SELECT setval('"public"."admins_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."banners_id_seq"
OWNED BY "public"."banners"."id";
SELECT setval('"public"."banners_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."customized_services_id_seq"
OWNED BY "public"."customized_services"."id";
SELECT setval('"public"."customized_services_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."goods_category_cid_seq"
OWNED BY "public"."goods_category"."cid";
SELECT setval('"public"."goods_category_cid_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."goods_description_id_seq"
OWNED BY "public"."goods_description"."id";
SELECT setval('"public"."goods_description_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."goods_detail_id_seq"
OWNED BY "public"."goods_detail"."id";
SELECT setval('"public"."goods_detail_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."goods_id_seq"
OWNED BY "public"."goods"."id";
SELECT setval('"public"."goods_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."goods_photo_pid_seq"
OWNED BY "public"."goods_photo"."pid";
SELECT setval('"public"."goods_photo_pid_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."honor_id_seq"
OWNED BY "public"."honor"."id";
SELECT setval('"public"."honor_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."index_works_id_seq"
OWNED BY "public"."index_works"."id";
SELECT setval('"public"."index_works_id_seq"', 31, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."linksnap_id_seq"
OWNED BY "public"."linksnap"."id";
SELECT setval('"public"."linksnap_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."public_welfare_info_id_seq"
OWNED BY "public"."public_welfare"."id";
SELECT setval('"public"."public_welfare_info_id_seq"', 7, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sessions_id_seq"
OWNED BY "public"."sessions"."id";
SELECT setval('"public"."sessions_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."to_approve_id_seq"
OWNED BY "public"."to_approve"."id";
SELECT setval('"public"."to_approve_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."users_id_seq"
OWNED BY "public"."users"."id";
SELECT setval('"public"."users_id_seq"', 2, false);

-- ----------------------------
-- Primary Key structure for table __diesel_schema_migrations
-- ----------------------------
ALTER TABLE "public"."__diesel_schema_migrations" ADD CONSTRAINT "__diesel_schema_migrations_pkey" PRIMARY KEY ("version");

-- ----------------------------
-- Indexes structure for table admins
-- ----------------------------
CREATE INDEX "idx_admins_email" ON "public"."admins" USING btree (
  "email" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_admins_role" ON "public"."admins" USING btree (
  "role" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_admins_username" ON "public"."admins" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table admins
-- ----------------------------
ALTER TABLE "public"."admins" ADD CONSTRAINT "admins_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table banners
-- ----------------------------
ALTER TABLE "public"."banners" ADD CONSTRAINT "banners_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table customized_services
-- ----------------------------
ALTER TABLE "public"."customized_services" ADD CONSTRAINT "customized_services_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table goods
-- ----------------------------
CREATE INDEX "idx_goods_enabled" ON "public"."goods" USING btree (
  "enabled" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "idx_goods_goods_name" ON "public"."goods" USING btree (
  "goods_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_goods_goods_sn" ON "public"."goods" USING btree (
  "goods_sn" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_goods_search_words" ON "public"."goods" USING btree (
  "search_words" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_goods_sn_unique" ON "public"."goods" USING btree (
  "goods_sn" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table goods
-- ----------------------------
ALTER TABLE "public"."goods" ADD CONSTRAINT "goods_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table goods_category
-- ----------------------------
CREATE INDEX "idx_goods_category_parent_id" ON "public"."goods_category" USING btree (
  "parent_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table goods_category
-- ----------------------------
ALTER TABLE "public"."goods_category" ADD CONSTRAINT "goods_category_pkey" PRIMARY KEY ("cid");

-- ----------------------------
-- Indexes structure for table goods_description
-- ----------------------------
CREATE INDEX "idx_goods_description_type" ON "public"."goods_description" USING btree (
  "type" "pg_catalog"."enum_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table goods_description
-- ----------------------------
ALTER TABLE "public"."goods_description" ADD CONSTRAINT "goods_description_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table goods_detail
-- ----------------------------
ALTER TABLE "public"."goods_detail" ADD CONSTRAINT "goods_detail_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table goods_photo
-- ----------------------------
ALTER TABLE "public"."goods_photo" ADD CONSTRAINT "goods_photo_pkey" PRIMARY KEY ("pid");

-- ----------------------------
-- Primary Key structure for table honor
-- ----------------------------
ALTER TABLE "public"."honor" ADD CONSTRAINT "honor_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table index_works
-- ----------------------------
ALTER TABLE "public"."index_works" ADD CONSTRAINT "index_works_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table linksnap
-- ----------------------------
ALTER TABLE "public"."linksnap" ADD CONSTRAINT "linksnap_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table public_welfare
-- ----------------------------
ALTER TABLE "public"."public_welfare" ADD CONSTRAINT "public_welfare_info_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sessions
-- ----------------------------
ALTER TABLE "public"."sessions" ADD CONSTRAINT "sessions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table to_approve
-- ----------------------------
CREATE INDEX "idx_to_approve_mobile" ON "public"."to_approve" USING btree (
  "mobile" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);
CREATE INDEX "idx_to_approve_status" ON "public"."to_approve" USING btree (
  "status" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_to_approve_user_id" ON "public"."to_approve" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_to_approve_user_type" ON "public"."to_approve" USING btree (
  "user_type" "pg_catalog"."int2_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table to_approve
-- ----------------------------
ALTER TABLE "public"."to_approve" ADD CONSTRAINT "to_approve_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table users
-- ----------------------------
CREATE UNIQUE INDEX "idx_sessions_cookie" ON "public"."users" USING btree (
  "mobile" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);
CREATE INDEX "idx_users_user_type" ON "public"."users" USING btree (
  "user_type" "pg_catalog"."int2_ops" ASC NULLS LAST
);
CREATE INDEX "idx_users_username" ON "public"."users" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table goods
-- ----------------------------
ALTER TABLE "public"."goods" ADD CONSTRAINT "goods_cid_fkey" FOREIGN KEY ("cid") REFERENCES "public"."goods_category" ("cid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table goods_description
-- ----------------------------
ALTER TABLE "public"."goods_description" ADD CONSTRAINT "goods_description_goods_id_fkey" FOREIGN KEY ("goods_id") REFERENCES "public"."goods" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table goods_detail
-- ----------------------------
ALTER TABLE "public"."goods_detail" ADD CONSTRAINT "goods_detail_goods_id_fkey" FOREIGN KEY ("goods_id") REFERENCES "public"."goods" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table goods_photo
-- ----------------------------
ALTER TABLE "public"."goods_photo" ADD CONSTRAINT "goods_photo_goods_id_fkey" FOREIGN KEY ("goods_id") REFERENCES "public"."goods" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table sessions
-- ----------------------------
ALTER TABLE "public"."sessions" ADD CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
