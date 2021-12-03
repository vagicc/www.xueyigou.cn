
CREATE TABLE goods_category(
    "cid" SERIAL PRIMARY KEY,
    "cname" CHARACTER VARYING(50),
    "parent_id" INTEGER NOT NULL DEFAULT 0,
    "level" SMALLINT NOT NULL DEFAULT 1,

    "seo_title" CHARACTER VARYING(255) DEFAULT NULL,
    "seo_keywords" CHARACTER VARYING(255) DEFAULT NULL,
    "seo_description" CHARACTER VARYING(255) DEFAULT NULL,

    "order_by" SMALLINT NOT NULL,
    "is_show" boolean DEFAULT TRUE,

    "modify_id" INTEGER DEFAULT NULL,
    "modify_time" TIMESTAMP WITHOUT time ZONE,
    "create_id" INTEGER DEFAULT NULL,
    "create_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
);
CREATE INDEX idx_goods_category_parent_id ON goods_category USING btree(parent_id);

COMMENT ON TABLE goods_category IS '商品分类表';
COMMENT ON COLUMN goods_category.cid IS '商品分类ID';
COMMENT ON COLUMN goods_category.cname IS '分类名称';
COMMENT ON COLUMN goods_category.parent_id IS '父分类ID';
COMMENT ON COLUMN goods_category.level IS '类别层级';
COMMENT ON COLUMN goods_category.seo_title IS 'SEO标题';
COMMENT ON COLUMN goods_category.seo_keywords IS 'SEO关键词';
COMMENT ON COLUMN goods_category.seo_description IS 'SEO描述';
COMMENT ON COLUMN goods_category.order_by IS '排序:小排前，大排后';
COMMENT ON COLUMN goods_category.is_show IS '是否显示：默认true显示，flase不显示';
COMMENT ON COLUMN goods_category.modify_id IS '最后修改者ID';
COMMENT ON COLUMN goods_category.modify_time IS '最后修改者时间';
COMMENT ON COLUMN goods_category.create_id IS '创建者ID';
COMMENT ON COLUMN goods_category.create_time IS '创建时间';

-- 商品、产品、服务相关表
CREATE TABLE goods(
    "id" SERIAL PRIMARY KEY,
    "cid" INTEGER DEFAULT NULL REFERENCES goods_category(cid),
    "goods_name" CHARACTER VARYING(80) NOT NULL,
    "goods_sn" CHARACTER VARYING(20) NOT NULL,
    "cost_price" MONEY NOT NULL DEFAULT 0,
    "market_price" MONEY NOT NULL DEFAULT 0,
    "sell_price" MONEY NOT NULL DEFAULT 0,
    "donate_proportion" NUMERIC(4,2) NOT NULL DEFAULT 0.00,

    "sku" CHARACTER VARYING(10) NOT NULL,
    "inventory" INTEGER NOT NULL DEFAULT 0,
    "goods_img" CHARACTER VARYING(255),
    "enabled" boolean DEFAULT TRUE,
    "search_words" CHARACTER VARYING(50) DEFAULT NULL,

    "visit" bigint NOT NULL DEFAULT 0,
    "sale" integer NOT NULL DEFAULT 0,
    "comments" bigint NOT NULL DEFAULT 0,
    "grade" SMALLINT NOT NULL DEFAULT 0,
    "up_time" TIMESTAMP WITHOUT time ZONE,
    "down_time" TIMESTAMP WITHOUT time ZONE,

    "create_id" INTEGER DEFAULT NULL,
    "create_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()

);

-- CREATE INDEX idx_goods_cid ON goods USING btree(cid);

CREATE INDEX idx_goods_goods_name ON goods USING btree(goods_name);

CREATE INDEX idx_goods_enabled ON goods USING btree(enabled);
CREATE INDEX idx_goods_search_words ON goods USING btree(search_words);
CREATE INDEX idx_goods_goods_sn ON goods USING btree(goods_sn);

CREATE UNIQUE INDEX idx_goods_sn_unique ON goods (goods_sn);

COMMENT ON TABLE goods IS '商品表';
COMMENT ON COLUMN goods.id IS '商品ID';
COMMENT ON COLUMN goods.cid IS '商品分类ID';
COMMENT ON COLUMN goods.goods_name IS '商品名称';
COMMENT ON COLUMN goods.goods_sn IS '商品货号';
COMMENT ON COLUMN goods.cost_price IS '成本价';
COMMENT ON COLUMN goods.market_price IS '市场价';
COMMENT ON COLUMN goods.sell_price IS '销售价';
COMMENT ON COLUMN goods.donate_proportion IS '捐赠比例：0为不捐赠、12.1为12.1%';
COMMENT ON COLUMN goods.sku IS '计件单位:件,箱,个,包，……';
COMMENT ON COLUMN goods.inventory IS '库存';
COMMENT ON COLUMN goods.goods_img IS '封面图(176*255)-列表显示的图片(外框width:201px;height:275px;)';
COMMENT ON COLUMN goods.enabled IS '是否在售：false为下架，true在售，unknown预定';
COMMENT ON COLUMN goods.search_words IS '商品搜索词库,逗号分隔';

COMMENT ON COLUMN goods.visit IS '浏览次数';
COMMENT ON COLUMN goods.sale IS '销量';
COMMENT ON COLUMN goods.comments IS '评论次数';
COMMENT ON COLUMN goods.grade IS '评分总数';

COMMENT ON COLUMN goods.up_time IS '上架时间';
COMMENT ON COLUMN goods.down_time IS '下架时间';

COMMENT ON COLUMN goods.create_id IS '上传者ID';
COMMENT ON COLUMN goods.create_time IS '创建时间';


CREATE TYPE goods_description_type AS ENUM ('PC','H5','APP');
CREATE TABLE goods_description(
    "id" SERIAL PRIMARY KEY,
    "goods_id" INTEGER NOT NULL REFERENCES goods(id),
    "type" goods_description_type DEFAULT 'PC'::goods_description_type,
    "description" text
);
CREATE INDEX idx_goods_description_type ON goods_description USING btree(type);
COMMENT ON COLUMN goods_description.goods_id IS '商品ID';
COMMENT ON COLUMN goods_description.type IS '商品详情类型：PC、H5、APP';
COMMENT ON COLUMN goods_description.description IS '商品详情描述';


CREATE TABLE goods_detail(
    "id" SERIAL PRIMARY KEY,
    "goods_id" INTEGER NOT NULL REFERENCES goods(id),
    "weight" NUMERIC(15, 2) NOT NULL DEFAULT 0.00,
    "size" CHARACTER VARYING(80),
    "color" CHARACTER VARYING(80),
    "excerpt" text,
    "free_shipping" boolean DEFAULT TRUE,
    "seo_title" CHARACTER VARYING(255) DEFAULT NULL,
    "seo_keywords" CHARACTER VARYING(255) DEFAULT NULL,
    "seo_description" CHARACTER VARYING(255) DEFAULT NULL,
    "modify_id" INTEGER DEFAULT NULL,
    "modify_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()  
);
COMMENT ON TABLE goods_detail IS '商品详情表';
COMMENT ON COLUMN goods_detail.weight IS '重量kg';
COMMENT ON COLUMN goods_detail.size IS '大小尺寸';
COMMENT ON COLUMN goods_detail.color IS '颜色';
COMMENT ON COLUMN goods_detail.excerpt IS '商品摘要:规格与包装';
COMMENT ON COLUMN goods_detail.free_shipping IS '是否免运费,默认免运费true';
COMMENT ON COLUMN goods_detail.seo_title IS 'SEO标题';
COMMENT ON COLUMN goods_detail.seo_keywords IS 'SEO关键词';
COMMENT ON COLUMN goods_detail.seo_description IS 'SEO描述';
COMMENT ON COLUMN goods_detail.modify_id IS '最后修改者ID';
COMMENT ON COLUMN goods_detail.modify_time IS '修改时间';


CREATE TABLE goods_photo(
    "pid" SERIAL PRIMARY KEY,
    "goods_id" INTEGER NOT NULL REFERENCES goods(id),
    "small" CHARACTER VARYING(255),
    "middle" CHARACTER VARYING(255),
    "original" CHARACTER VARYING(255),

    "path" CHARACTER VARYING(255),
    "title" CHARACTER VARYING(58),
    "extension" CHARACTER VARYING(8),
    "type" CHARACTER VARYING(18),

    "create_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
);
COMMENT ON TABLE goods_photo IS '商品相册表';
COMMENT ON COLUMN goods_photo.goods_id IS '商品ID';
COMMENT ON COLUMN goods_photo.small IS '小图(100*47)';
COMMENT ON COLUMN goods_photo.middle IS '中图(289*318)';
COMMENT ON COLUMN goods_photo.original IS '原图(578*637)';
COMMENT ON COLUMN goods_photo.path IS '图片路径';
COMMENT ON COLUMN goods_photo.title IS '图片名不带扩展';
COMMENT ON COLUMN goods_photo.extension IS '图片扩展名如：jpg';
COMMENT ON COLUMN goods_photo.type IS '图片类型如：image/jpeg';
