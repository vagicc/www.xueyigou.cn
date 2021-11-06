---------------------------学艺购商城表 start ---------------------------
-- (学校所在地，年级，学生编号以及个人专业方向，还有就是实名认证本人，确认本人信息无误)
-- 学校名，学样所在地， 专业，年级，学生编号，学生证，本人实名认证手机号，真实姓名，身份证号码,身份证正面，反面. 
CREATE TABLE to_approve(
    "id" serial PRIMARY KEY,
    "real_name" CHARACTER VARYING(20) NOT NULL,
    "school" CHARACTER VARYING(100) NOT NULL,
    "school_address" varchar(255) DEFAULT NULL,
    "professional" CHARACTER VARYING(100) DEFAULT NULL,
    "class" CHARACTER VARYING(50) DEFAULT NULL,
    "student_no" CHARACTER VARYING(100) DEFAULT NULL,
    "student_certificate" CHARACTER VARYING(255) DEFAULT NULL,
    "identity_card" CHARACTER(18) NOT NULL,
    "identity_document" CHARACTER VARYING(255) DEFAULT NULL,
    "mobile" CHARACTER(11) NOT NULL,
    "status" SMALLINT NOT NULL DEFAULT 0,
    "customer_id" INTEGER NOT NULL,
    "modify_id" INTEGER DEFAULT NULL,
    "modify_time" TIMESTAMP WITHOUT time ZONE,
    "add_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
);
CREATE INDEX idx_to_approve_customer_id ON to_approve USING btree(customer_id);
COMMENT ON TABLE to_approve IS '学生认证表';
COMMENT ON COLUMN to_approve.id IS 'ID';
COMMENT ON COLUMN to_approve.real_name IS '真实姓名';
COMMENT ON COLUMN to_approve.school IS '所在学校';
COMMENT ON COLUMN to_approve.school_address IS '所在学校地址';
COMMENT ON COLUMN to_approve.professional IS '所属专业';
COMMENT ON COLUMN to_approve.class IS '所属年级';
COMMENT ON COLUMN to_approve.student_no IS '学生编号';
COMMENT ON COLUMN to_approve.student_certificate IS '学生证';
COMMENT ON COLUMN to_approve.identity_card IS '身份证号码';
COMMENT ON COLUMN to_approve.identity_document IS '身份证照片';
COMMENT ON COLUMN to_approve.mobile IS '本人实名认证手机号';
COMMENT ON COLUMN to_approve.status IS '状态：0默认待审核，-1审核不通过，1审核通过';
COMMENT ON COLUMN to_approve.modify_id IS '后台审核修改ID';
COMMENT ON COLUMN to_approve.customer_id IS '会员ID';
COMMENT ON COLUMN to_approve.modify_time IS '修改时间';
COMMENT ON COLUMN to_approve.add_time IS '添加时间';
------------------------------商城表 start------------------------------
CREATE TABLE to_gust(
    "gust_id" serial PRIMARY key,
    "customer_id" INTEGER NOT NULL,
    "add_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
);
CREATE INDEX idx_to_gust_goods_customer_id ON to_gust USING btree(customer_id);
COMMENT ON TABLE to_gust IS '购物车表';
COMMENT ON COLUMN to_gust.gust_id IS '购物车ID';
COMMENT ON COLUMN to_gust.customer_id IS '客户（会员）ID,未登录则插入0';

CREATE TABLE to_gust_detail(
    "id" serial PRIMARY KEY,
    "gust_id" INTEGER NOT NULL,
    "goods_id" INTEGER NOT NULL,
    "goods_sn" CHARACTER VARYING(20),
    "qty" INTEGER NOT NULL DEFAULT 1,
    "select"  BOOLEAN DEFAULT TRUE,
    "ip" inet NOT NULL,
    "time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
);
CREATE INDEX idx_to_gust_detail_gust_id ON to_gust_detail USING btree(gust_id);
CREATE INDEX idx_to_gust_detail_goods_id ON to_gust_detail USING btree(goods_id);
COMMENT ON TABLE to_gust_detail IS '购物车详情表';
COMMENT ON COLUMN to_gust_detail.id IS '购物车详情ID';
COMMENT ON COLUMN to_gust_detail.gust_id IS '购物车ID 或 cookie_id';
COMMENT ON COLUMN to_gust_detail.goods_id IS '商品ID';
COMMENT ON COLUMN to_gust_detail.goods_sn IS '商品货号';
COMMENT ON COLUMN to_gust_detail.qty IS '数量';
COMMENT ON COLUMN to_gust_detail.select IS '是否选中：默认true选中，false没选';
COMMENT ON COLUMN to_gust_detail.ip IS 'IP地址';
COMMENT ON COLUMN to_gust_detail.time IS '时间';
-- 购物车表
-- DROP TABLE IF EXISTS `to_gust`;
-- CREATE TABLE IF NOT EXISTS `to_gust`(
-- 	`gust_id` int(11) unsigned AUTO_INCREMENT COMMENT '购物车ID',
-- 	`customer_id` int(11) unsigned NOT NULL COMMENT '客户（会员）ID',
-- 	`add_time` bigint(20) COMMENT '时间',
-- 	PRIMARY KEY (`gust_id`),
-- 	KEY `customer_id` (`customer_id`)
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购物车表';

-- DROP TABLE IF EXISTS `to_gust_detail`;
-- CREATE TABLE IF NOT EXISTS `to_gust_detail`(
-- 	`id` int(11) unsigned AUTO_INCREMENT COMMENT '购物车详情ID',
-- 	`gust_id` int(11) NOT NULL COMMENT '购物车ID 或 cookie_id',
-- 	`goods_id` int(11) unsigned NOT NULL COMMENT '商品ID',
-- 	`goods_sn` varchar(20) COMMENT '商品货号',
-- 	`qty` int(11) NOT NULL DEFAULT '1' COMMENT '数量',
-- 	`select` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否选中：默认1选中，0没选',
-- 	`ip` varchar(20) DEFAULT NULL COMMENT 'IP地址',
-- 	`time` bigint(20) COMMENT '时间',
-- 	PRIMARY KEY (`id`),
-- 	KEY `gust_id` (`gust_id`),
-- 	KEY `goods_id` (`goods_id`)
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购物车详情表';

CREATE TABLE to_order_goods(
    "id" serial PRIMARY KEY,
    "order_id" INTEGER NOT NULL,
    "order_sn" CHARACTER VARYING(20) NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "goods_id" INTEGER NOT NULL,
    "goods_name" CHARACTER VARYING(80) NOT NULL,
    "goods_img" CHARACTER VARYING(255),
    "goods_sn" CHARACTER VARYING(20),
    "price" MONEY NOT NULL,
    "qty" INTEGER NOT NULL DEFAULT 1,
    "weight" NUMERIC(15,2) NOT NULL DEFAULT 0.00,
    "after_sale" INTEGER NOT NULL DEFAULT 0,
    "shipment" SMALLINT NOT NULL DEFAULT 0,
    "order_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
);
CREATE INDEX idx_to_order_goods_order_id ON to_order_goods USING btree(order_id);
CREATE INDEX idx_to_order_goods_goods_id ON to_order_goods USING btree(goods_id);
CREATE INDEX idx_to_order_goods_customer_id ON to_order_goods USING btree(customer_id);
CREATE INDEX idx_to_order_goods_order_sn ON to_order_goods USING btree(order_sn);
COMMENT ON TABLE to_order_goods IS '订单商品详情表';
COMMENT ON COLUMN to_order_goods.order_id IS '订单ID';
COMMENT ON COLUMN to_order_goods.order_sn IS '订单编号';
COMMENT ON COLUMN to_order_goods.customer_id IS '客户（会员）ID';
COMMENT ON COLUMN to_order_goods.goods_id IS '商品ID';
COMMENT ON COLUMN to_order_goods.goods_name IS '商品名称';
COMMENT ON COLUMN to_order_goods.goods_img IS '商品图';
COMMENT ON COLUMN to_order_goods.goods_sn IS '商品货号';
COMMENT ON COLUMN to_order_goods.price IS '购买价';
COMMENT ON COLUMN to_order_goods.qty IS '购买数量';
COMMENT ON COLUMN to_order_goods.weight IS '重量kg';
COMMENT ON COLUMN to_order_goods.after_sale IS '售后：0默认,售后ID';
COMMENT ON COLUMN to_order_goods.shipment IS '配送ID:0未发送,配送ID';
COMMENT ON COLUMN to_order_goods.order_time IS '下单时间';
-- DROP TABLE IF EXISTS `to_order_goods`;
-- CREATE TABLE IF NOT EXISTS `to_order_goods`(
-- 	`id` int(11) unsigned AUTO_INCREMENT COMMENT 'ID',
-- 	`order_id` int(11) NOT NULL COMMENT '订单ID',
-- 	`order_sn` varchar(20) NOT NULL COMMENT '订单编号',
-- 	`customer_id` int(11) unsigned NOT NULL COMMENT '客户（会员）ID',
-- 	`goods_id` int(11) unsigned NOT NULL COMMENT '商品ID',
-- 	`goods_name` varchar(80) NOT NULL COMMENT '商品名称',
-- 	`goods_img` varchar(255) COMMENT '商品图',
-- 	`goods_sn` varchar(20) COMMENT '商品货号',
-- 	`price` decimal(15,2) DEFAULT NULL COMMENT '购买价',
-- 	`qty` int(11) NOT NULL DEFAULT '1' COMMENT '购买数量',
-- 	`sku` varchar(10) NOT NULL COMMENT '计件单位:件,箱,个,包,等',
-- 	`weight` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT '重量kg',
-- 	`after_sale` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '售后：0默认,售后ID',
--     `shipment` int(11) NOT NULL DEFAULT '0' COMMENT '配送ID:0未发送,配送ID',
-- 	`order_time` bigint(20) COMMENT '下单时间',
-- 	PRIMARY KEY (`id`),
-- 	KEY `order_id` (`order_id`),
-- 	KEY `goods_id` (`goods_id`),
-- 	KEY `customer_id` (`customer_id`)
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单商品详情表';

CREATE TABLE to_order(
    "order_id" SERIAL PRIMARY KEY,
    "customer_id" INTEGER NOT NULL,
    "order_sn" CHARACTER VARYING(20) NOT NULL,

    "consignee" CHARACTER VARYING(20) NOT NULL,
    "province" CHARACTER VARYING(20) NOT NULL,
    "city" CHARACTER VARYING(20) NOT NULL,
    "address" CHARACTER VARYING(250) NOT NULL,
    "postcode" CHARACTER(6) DEFAULT NULL,
    "mobile" CHARACTER(11) NOT NULL,

    "freight" MONEY NOT NULL DEFAULT 0.00,
    "shipment" SMALLINT NOT NULL DEFAULT 0,
    "send_time" TIMESTAMP WITHOUT time ZONE,

    "payable" MONEY NOT NULL DEFAULT 0,
    "real_amount" MONEY NOT NULL,

    "invoice" INTEGER NOT NULL DEFAULT 0,

    "postscript" CHARACTER VARYING(255) DEFAULT NULL,
    "note" CHARACTER VARYING(255) DEFAULT NULL,

    "type" SMALLINT NOT NULL DEFAULT 0,
    "status" SMALLINT NOT NULL DEFAULT 1,
    "source" CHARACTER VARYING(100) DEFAULT NULL,

    "modify_id" INTEGER DEFAULT NULL,
    "modify_time" TIMESTAMP WITHOUT time ZONE,
    "create_id" INTEGER DEFAULT NULL,
    "create_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
);
CREATE INDEX idx_to_order_order_sn ON to_order USING btree(order_sn);
CREATE INDEX idx_to_order_customer_id ON to_order USING btree(customer_id);
CREATE INDEX idx_to_order_status ON to_order USING btree(status);
COMMENT ON TABLE to_order IS '订单表';
COMMENT ON COLUMN to_order.order_id IS '订单ID';
COMMENT ON COLUMN to_order.customer_id IS '客户（会员）ID';
COMMENT ON COLUMN to_order.order_sn IS '订单编号';
COMMENT ON COLUMN to_order.consignee IS '收货人';
COMMENT ON COLUMN to_order.province IS '省份';
COMMENT ON COLUMN to_order.city IS '城市';
COMMENT ON COLUMN to_order.address IS '收货地址';
COMMENT ON COLUMN to_order.postcode IS '邮编';
COMMENT ON COLUMN to_order.mobile IS '收货手机号码';
COMMENT ON COLUMN to_order.freight IS '运费0免费，多少填多少';
COMMENT ON COLUMN to_order.shipment IS '配送ID:0未发送,配送ID';
COMMENT ON COLUMN to_order.send_time IS '发货时间';
COMMENT ON COLUMN to_order.payable IS '应付金额';
COMMENT ON COLUMN to_order.real_amount IS '实付金额';
COMMENT ON COLUMN to_order.invoice IS '发票：0不开票，-1.开票中，-2.已开发票，发票ID';
COMMENT ON COLUMN to_order.postscript IS '用户留言';
COMMENT ON COLUMN to_order.note IS '管理员备注描述等';
COMMENT ON COLUMN to_order.type IS '订单类型 （0普通订单、1团购订单、2拼团订单、3限时抢购）';
COMMENT ON COLUMN to_order.status IS '订单状态:1生成订单,2订单已支付,3订单已发货,4已签收,5订单完成，-1取消订单(客户触发),-2作废订单(管理员触发),6退款(订单完成后),7部分退款(订单完成后)';
COMMENT ON COLUMN to_order.source IS '订单来源（后台，微信PC,或者网址,IP等，还没想好）';
COMMENT ON COLUMN to_order.create_id IS '下单ID(后台用户ID用负数)';
COMMENT ON COLUMN to_order.create_time IS '下单时间';
COMMENT ON COLUMN to_order.modify_id IS '改者ID';
COMMENT ON COLUMN to_order.modify_time IS '修改时间';

-- DROP TABLE IF EXISTS `to_order`;
-- CREATE TABLE IF NOT EXISTS `to_order`(
-- 	`order_id` int(11) unsigned AUTO_INCREMENT COMMENT '订单ID',
-- 	`customer_id` int(11) unsigned NOT NULL COMMENT '客户（会员）ID',
-- 	`order_sn` varchar(20) NOT NULL COMMENT '订单编号',

-- 	`consignee` varchar(20) NOT NULL COMMENT '收货人',
-- 	`province` varchar(20) NOT NULL COMMENT '省份',
--     `city` varchar(20) NOT NULL COMMENT '城市',
-- 	`address` varchar(250) DEFAULT NULL COMMENT '收货地址',
-- 	`postcode` char(6) DEFAULT NULL COMMENT '邮编',
-- 	`mobile` char(11) DEFAULT NULL COMMENT '收货手机号码',
    
-- 	`freight` tinyint(1) NOT NULL DEFAULT '0' COMMENT '运费0免费，多少填多少',
--     `shipment` int(11) DEFAULT '0' COMMENT '配送ID:0未发送,配送ID',
--     `send_time` bigint(20) DEFAULT NULL COMMENT '发货时间',

--     `payable` decimal(15,2) DEFAULT NULL COMMENT '应付金额', 
--     `real_amount` decimal(15,2) DEFAULT NULL COMMENT '实付金额',

--     `invoice` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发票：0不开票，-1.开票中，-2.已开发票，发票ID',

-- 	`postscript` varchar(255) DEFAULT NULL COMMENT '用户留言',
-- 	`note` varchar(255) DEFAULT NULL COMMENT '管理员备注描述等',

-- 	`type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单类型 （0普通订单、1团购订单、2拼团订单、3限时抢购）',
--     `status` tinyint(1) DEFAULT '1' COMMENT '订单状态:1生成订单,2订单已支付,3订单已发货,4已签收,5订单完成，-1取消订单(客户触发),-2作废订单(管理员触发),6退款(订单完成后),7部分退款(订单完成后)',
--     `source` varchar(189) DEFAULT NULL COMMENT '订单来源（后台，微信PC,或者网址,IP等，还没想好）',

-- 	`create_id` int(11) unsigned COMMENT '下单ID(后台用户ID用负数)',
--     `create_time` bigint(20) COMMENT '下单时间',
-- 	`modify_id` int(11) unsigned COMMENT '改者ID',
-- 	`modify_time` datetime COMMENT '修改时间',
-- 	PRIMARY KEY (`order_id`),
-- 	KEY `customer_id` (`customer_id`),
-- 	KEY `order_sn` (`order_sn`),
-- 	KEY `status` (`status`)
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

CREATE TYPE invoice_type AS ENUM ('增值税专用发票','增值税普通发票','增值税电子普通发票','定额发票','通用机打发票','其它');
CREATE TABLE to_invoice(
    "id" SERIAL PRIMARY KEY,
    "order_id" INTEGER NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "type" invoice_type DEFAULT '增值税电子普通发票'::invoice_type,
    "company" CHARACTER VARYING(80) NOT NULL,
    "taxcode" CHARACTER VARYING(30) DEFAULT NULL,
    "address" CHARACTER VARYING(100) DEFAULT NULL,
    "telphone" CHARACTER VARYING(20) DEFAULT NULL,
    "bankname" CHARACTER VARYING(80) DEFAULT NULL,
    "bankno" CHARACTER VARYING(30) DEFAULT NULL
);
CREATE INDEX idx_to_invoice_order_id ON to_invoice USING btree(order_id);
CREATE INDEX idx_to_invoice_customer_id ON to_invoice USING btree(customer_id);
COMMENT ON TABLE to_invoice IS '发票表';
COMMENT ON COLUMN to_invoice.id IS 'ID';
COMMENT ON COLUMN to_invoice.order_id IS '订单ID';
COMMENT ON COLUMN to_invoice.customer_id IS '客户（会员）ID';
COMMENT ON COLUMN to_invoice.type IS '发票类别';
COMMENT ON COLUMN to_invoice.company IS '单位名称';
COMMENT ON COLUMN to_invoice.taxcode IS '纳税人识别码';
COMMENT ON COLUMN to_invoice.address IS '注册地址';
COMMENT ON COLUMN to_invoice.telphone IS '注册电话';
COMMENT ON COLUMN to_invoice.bankname IS '开户银行';
COMMENT ON COLUMN to_invoice.bankno IS '银行账户';
-- DROP TABLE IF EXISTS `to_invoice`;
-- CREATE TABLE IF NOT EXISTS `to_invoice` (
-- 	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
-- 	`order_id` int(11) NOT NULL COMMENT '订单ID',
-- 	`customer_id` int(11) unsigned NOT NULL COMMENT '客户（会员）ID',
-- 	`type` enum('增值税专用发票','增值税普通发票','增值税电子普通发票','定额发票','通用机打发票','其它') DEFAULT '增值税电子普通发票' COMMENT '发票类别',
-- 	`company` varchar(80) NOT NULL COMMENT '单位名称',
-- 	`taxcode` varchar(30) NOT NULL COMMENT '纳税人识别码',
-- 	`address` varchar(100) DEFAULT NULL COMMENT '注册地址',
-- 	`telphone` varchar(20) DEFAULT NULL COMMENT '注册电话',
-- 	`bankname` varchar(80) DEFAULT NULL COMMENT '开户银行',
-- 	`bankno` varchar(30) DEFAULT NULL COMMENT '银行账户',
-- 	PRIMARY KEY (`id`),
-- 	KEY `order_id` (`order_id`),
-- 	KEY `customer_id` (`customer_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发票表';

CREATE TABLE to_favorite(
    "id" SERIAL PRIMARY KEY,
    "customer_id" INTEGER NOT NULL,
    "goods_id" INTEGER NOT NULL,
    "collection" MONEY NOT NULL,
    "add" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp(),
    "depreciate" MONEY NOT NULL DEFAULT 0.00,
    "mobile" CHARACTER(11) DEFAULT NULL,
    "email" CHARACTER VARYING(100) DEFAULT NULL
);
-- 后台修改商品价格时，就做商品降价通知
CREATE INDEX idx_to_favorite_customer_id ON to_favorite USING btree(customer_id);
CREATE INDEX idx_to_favorite_goods_id ON to_favorite USING btree(goods_id);
COMMENT ON TABLE to_favorite IS '商品收藏表';
COMMENT ON COLUMN to_favorite.id IS '收藏ID';
COMMENT ON COLUMN to_favorite.customer_id IS '客户（会员）ID';
COMMENT ON COLUMN to_favorite.goods_id IS '商品ID';
COMMENT ON COLUMN to_favorite.collection IS '收藏时价格';
COMMENT ON COLUMN to_favorite.add IS '添加时间';
COMMENT ON COLUMN to_favorite.depreciate IS '降到此价通知我';
COMMENT ON COLUMN to_favorite.mobile IS '降价通知手机';
COMMENT ON COLUMN to_favorite.email IS '降价通知邮箱';

-- DROP TABLE IF EXISTS `to_favorite`;
-- -- 后台修改商品价格时，就做商品降价通知
-- CREATE TABLE IF NOT EXISTS `to_favorite`(
-- 	`id` int(11) unsigned AUTO_INCREMENT COMMENT '收藏ID',
-- 	`customer_id` int(11) unsigned NOT NULL COMMENT '客户（会员）ID',
-- 	`goods_id` int(11) unsigned NOT NULL COMMENT '商品ID',
-- 	`collection` decimal(15,2) DEFAULT NULL COMMENT '收藏时价格',
-- 	`add` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
-- 	`depreciate` decimal(15,2) DEFAULT NULL COMMENT '降到此价通知我',
-- 	`mobile` char(11) DEFAULT NULL COMMENT '降价通知手机',
--     `email` varchar(100) DEFAULT NULL COMMENT '降价通知邮箱',
-- 	PRIMARY KEY (`id`),
-- 	KEY `goods_id` (`goods_id`),
-- 	KEY `customer_id` (`customer_id`)
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品收藏表';

CREATE TABLE to_address(
    "id" SERIAL PRIMARY KEY,
    "customer_id" INTEGER NOT NULL,
    "alias" CHARACTER VARYING(20),
    "consignee" CHARACTER VARYING(20) NOT NULL,
    "province" CHARACTER VARYING(20) NOT NULL,
    "city" CHARACTER VARYING(20) NOT NULL,
    "address" CHARACTER VARYING(250) NOT NULL,
    "postcode" CHARACTER(6) DEFAULT NULL,
    "mobile" CHARACTER(11) NOT NULL,
    "default" BOOLEAN DEFAULT FALSE,
    "create_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
);
CREATE INDEX idx_to_address_customer_id ON to_address USING btree(customer_id);
COMMENT ON TABLE to_address IS '收货地址表';
COMMENT ON COLUMN to_address.id IS '收货地址ID';
COMMENT ON COLUMN to_address.customer_id IS '客户（会员）ID';
COMMENT ON COLUMN to_address.alias IS '地址别名';
COMMENT ON COLUMN to_address.consignee IS '收货人';
COMMENT ON COLUMN to_address.province IS '省份';
COMMENT ON COLUMN to_address.city IS '城市';
COMMENT ON COLUMN to_address.address IS '收货地址';
COMMENT ON COLUMN to_address.postcode IS '邮编';
COMMENT ON COLUMN to_address.mobile IS '收货手机号码';
COMMENT ON COLUMN to_address.default IS '是否默认收货地址,false:为非默认,true:默认';
COMMENT ON COLUMN to_address.create_time IS '创建时间';

-- DROP TABLE IF EXISTS `to_address`;
-- CREATE TABLE IF NOT EXISTS `to_address`(
-- 	`id` int(11) unsigned AUTO_INCREMENT COMMENT '地址ID',
-- 	`customer_id` int(11) unsigned NOT NULL COMMENT '客户（会员）ID',
-- 	`alias` varchar(20) NOT NULL COMMENT '地址别名',

-- 	`consignee` varchar(20) NOT NULL COMMENT '收货人',
--     `province` varchar(20) NOT NULL COMMENT '省份',
--     `city` varchar(20) NOT NULL COMMENT '城市',
-- 	`address` varchar(250) DEFAULT NULL COMMENT '收货地址',

-- 	`postcode` char(6) DEFAULT NULL COMMENT '邮编',
-- 	`mobile` char(11) DEFAULT NULL COMMENT '收货手机号码',
-- 	`default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认,0:为非默认,1:默认',
-- 	`create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
-- 	PRIMARY KEY (`id`),
-- 	KEY `customer_id` (`customer_id`)
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收货地址表';

CREATE TABLE to_category(
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
COMMENT ON TABLE to_category IS '商品分类表';
COMMENT ON COLUMN to_category.cid IS '商品分类ID';
COMMENT ON COLUMN to_category.cname IS '分类名称';
COMMENT ON COLUMN to_category.parent_id IS '父分类ID';
COMMENT ON COLUMN to_category.level IS '类别层级';
COMMENT ON COLUMN to_category.seo_title IS 'SEO标题';
COMMENT ON COLUMN to_category.seo_keywords IS 'SEO关键词';
COMMENT ON COLUMN to_category.seo_description IS 'SEO描述';
COMMENT ON COLUMN to_category.order_by IS '排序:小排前，大排后';
COMMENT ON COLUMN to_category.is_show IS '是否显示：默认true显示，flase不显示';
COMMENT ON COLUMN to_category.modify_id IS '最后修改者ID';
COMMENT ON COLUMN to_category.modify_time IS '最后修改者时间';
COMMENT ON COLUMN to_category.create_id IS '创建者ID';
COMMENT ON COLUMN to_category.create_time IS '创建时间';

-- DROP TABLE IF EXISTS `to_category`;
-- CREATE TABLE IF NOT EXISTS `to_category`(
-- 	`cid` int(11) unsigned AUTO_INCREMENT COMMENT '商品分类ID',
-- 	`cname` varchar(50) NOT NULL COMMENT '分类名称',
-- 	`parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父分类ID',
-- 	`level` int(11) unsigned NOT NULL DEFAULT '1' COMMENT '类别层级',

-- 	`seo_title` varchar(255) DEFAULT NULL COMMENT 'SEO关键词',
-- 	`seo_keywords` varchar(255) DEFAULT NULL COMMENT 'SEO关键词',
-- 	`seo_description` varchar(255) DEFAULT NULL COMMENT 'SEO描述',

--     `order_by` tinyint(2) unsigned NOT NULL COMMENT '排序:小排前，大排后',
--     `is_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示：默认1显示，0不显示',

--     `modify_id` int(11) unsigned COMMENT '最后修改者ID',
-- 	`modify_time` datetime COMMENT '修改时间',
-- 	`create_id` int(11) unsigned COMMENT '创建者ID',
--     `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
--     PRIMARY KEY (`cid`)
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品分类表';

CREATE TABLE to_goods_photo(
    "pid" SERIAL PRIMARY KEY,
    "gid" INTEGER DEFAULT NULL,
    "small" CHARACTER VARYING(255),
    "middle" CHARACTER VARYING(255),
    "original" CHARACTER VARYING(255),

    "path" CHARACTER VARYING(255),
    "title" CHARACTER VARYING(58),
    "extension" CHARACTER VARYING(8),
    "type" CHARACTER VARYING(18),

    "create_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
);
CREATE INDEX idx_to_goods_photo_gid ON to_goods_photo USING btree(gid);
COMMENT ON TABLE to_goods_photo IS '商品相册表';
COMMENT ON COLUMN to_goods_photo.gid IS '商品ID';
COMMENT ON COLUMN to_goods_photo.small IS '小图(100*47)';
COMMENT ON COLUMN to_goods_photo.middle IS '中图(289*318)';
COMMENT ON COLUMN to_goods_photo.original IS '原图(578*637)';
COMMENT ON COLUMN to_goods_photo.path IS '图片路径';
COMMENT ON COLUMN to_goods_photo.title IS '图片名不带扩展';
COMMENT ON COLUMN to_goods_photo.extension IS '图片扩展名如：jpg';
COMMENT ON COLUMN to_goods_photo.type IS '图片类型如：image/jpeg';
-- DROP TABLE IF EXISTS `to_goods_photo`;
-- CREATE TABLE IF NOT EXISTS `to_goods_photo`(
-- 	`pid` int(11) unsigned AUTO_INCREMENT COMMENT 'photoID',
-- 	`gid` int(11) DEFAULT NULL COMMENT '商品ID',
-- 	`small` varchar(255) COMMENT '小图(100*47)',
-- 	`middle` varchar(255) COMMENT '中图(289*318)',
-- 	`original` varchar(255) COMMENT '原图(578*637)',
    
-- 	`path` varchar(255) COMMENT '图片路径',
-- 	`title` varchar(58) COMMENT '图片名不带扩展',
-- 	`type` varchar(18) COMMENT '图片类型如：image/jpeg', 
-- 	`extension` varchar(8) COMMENT '图片扩展名如：jpg',

-- 	`create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
-- 	PRIMARY KEY (`pid`),
-- 	KEY `gid` (`gid`)
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品相册表';

CREATE TABLE to_goods(
    "id" SERIAL PRIMARY KEY,
    "cid" INTEGER DEFAULT NULL,
    "goods_name" CHARACTER VARYING(80) NOT NULL,
    "goods_sn" CHARACTER VARYING(20) NOT NULL,
    "cost_price" MONEY NOT NULL DEFAULT 0,
    "market_price" MONEY NOT NULL DEFAULT 0,
    "sell_price" MONEY NOT NULL DEFAULT 0,
    "sku" CHARACTER VARYING(10) NOT NULL,
    "inventory" INTEGER NOT NULL DEFAULT 0,
    "weight" NUMERIC(15,2) NOT NULL DEFAULT 0.00,
    "size" CHARACTER VARYING(80),
    "goods_img" CHARACTER VARYING(255),

    "excerpt" text,
    "description" text,
    "free_shipping" boolean DEFAULT TRUE,
    "enabled" boolean DEFAULT TRUE,

    "seo_title" CHARACTER VARYING(255) DEFAULT NULL,
    "seo_keywords" CHARACTER VARYING(255) DEFAULT NULL,
    "seo_description" CHARACTER VARYING(255) DEFAULT NULL,
    "search_words" CHARACTER VARYING(50) DEFAULT NULL,

    "visit" bigint NOT NULL DEFAULT 0,
    "sale" integer NOT NULL DEFAULT 0,
    "comments" bigint NOT NULL DEFAULT 0,
    "grade" SMALLINT NOT NULL DEFAULT 0,

    "up_time" TIMESTAMP WITHOUT time ZONE,
    "down_time" TIMESTAMP WITHOUT time ZONE,
    "modify_id" INTEGER DEFAULT NULL,
    "modify_time" TIMESTAMP WITHOUT time ZONE,
    "create_id" INTEGER DEFAULT NULL,
    "create_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
);
CREATE INDEX idx_to_goods_goods_name ON to_goods USING btree(goods_name);
COMMENT ON TABLE to_goods IS '商品表';
COMMENT ON COLUMN to_goods.id IS '商品ID';
COMMENT ON COLUMN to_goods.cid IS '商品分类ID';
COMMENT ON COLUMN to_goods.goods_name IS '商品名称';
COMMENT ON COLUMN to_goods.goods_sn IS '商品货号';
COMMENT ON COLUMN to_goods.cost_price IS '成本价';
COMMENT ON COLUMN to_goods.market_price IS '市场价';
COMMENT ON COLUMN to_goods.sell_price IS '销售价';
COMMENT ON COLUMN to_goods.sku IS '计件单位:件,箱,个,包，……';
COMMENT ON COLUMN to_goods.inventory IS '库存';
COMMENT ON COLUMN to_goods.weight IS '重量kg';
COMMENT ON COLUMN to_goods.size IS '大小尺寸';
COMMENT ON COLUMN to_goods.goods_img IS '商品图(176*255)-列表显示的图片(外框width:201px;height:275px;)';
COMMENT ON COLUMN to_goods.excerpt IS '商品摘要:规格与包装';
COMMENT ON COLUMN to_goods.description IS '商品描述';
COMMENT ON COLUMN to_goods.free_shipping IS '是否免运费,默认免运费true';
COMMENT ON COLUMN to_goods.enabled IS '是否在售：false为下架，true在售，unknown预定';
COMMENT ON COLUMN to_goods.seo_title IS 'SEO标题';
COMMENT ON COLUMN to_goods.seo_keywords IS 'SEO关键词';
COMMENT ON COLUMN to_goods.seo_description IS 'SEO描述';
COMMENT ON COLUMN to_goods.search_words IS '商品搜索词库,逗号分隔';
COMMENT ON COLUMN to_goods.visit IS '浏览次数';
COMMENT ON COLUMN to_goods.sale IS '销量';
COMMENT ON COLUMN to_goods.comments IS '评论次数';
COMMENT ON COLUMN to_goods.grade IS '评分总数';
COMMENT ON COLUMN to_goods.up_time IS '上架时间';
COMMENT ON COLUMN to_goods.down_time IS '下架时间';
COMMENT ON COLUMN to_goods.modify_id IS '最后修改者ID';
COMMENT ON COLUMN to_goods.modify_time IS '修改时间';
COMMENT ON COLUMN to_goods.create_id IS '上传者ID';
COMMENT ON COLUMN to_goods.create_time IS '创建时间';

-- DROP TABLE IF EXISTS `to_goods`;
-- CREATE TABLE IF NOT EXISTS `to_goods`(
-- 	`id` int(11) unsigned AUTO_INCREMENT COMMENT '商品ID',
-- 	`cid` int(11) DEFAULT NULL COMMENT '商品分类ID',
-- 	`goods_name` varchar(80) NOT NULL COMMENT '商品名称',
-- 	`goods_sn` varchar(20) COMMENT '商品货号',
-- 	`cost_price` decimal(15,2) DEFAULT '0' COMMENT '成本价',
-- 	`market_price` decimal(15,2) DEFAULT '0' COMMENT '市场价',
-- 	`sell_price` decimal(15,2) DEFAULT '0' COMMENT '销售价',
-- 	`sku` varchar(10) NOT NULL COMMENT '计件单位:件,箱,个,包,等',
-- 	`inventory` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
-- 	`weight` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT '重量kg',
-- 	`size` varchar(80) COMMENT '大小尺寸',
--  `goods_img` varchar(255) COMMENT '商品图(176*255)-列表显示的图片(外框width:201px;height:275px;)',
--  `excerpt` text COMMENT '商品摘要:规格与包装',
-- 	`description` text COMMENT '商品描述',
-- 	`free_shipping` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否免运费：0免运费',
--  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否在售：0为下架，1在售，2预定',
-- 	`seo_title` varchar(255) DEFAULT NULL COMMENT 'SEO关键词',
-- 	`seo_keywords` varchar(255) DEFAULT NULL COMMENT 'SEO关键词',
-- 	`seo_description` varchar(255) DEFAULT NULL COMMENT 'SEO描述',
-- 	`search_words` varchar(50) DEFAULT NULL COMMENT '商品搜索词库,逗号分隔',
-- 	`visit` int(11) NOT NULL DEFAULT '0' COMMENT '浏览次数',
-- 	`sale` int(11) NOT NULL DEFAULT '0' COMMENT '销量',
-- 	`comments` int(11) NOT NULL DEFAULT '0' COMMENT '评论次数',
-- 	`grade` int(11) NOT NULL DEFAULT '0' COMMENT '评分总数',
-- 	`up_time` datetime DEFAULT NULL COMMENT '上架时间',
-- 	`down_time` datetime DEFAULT NULL COMMENT '下架时间',
-- 	`modify_id` int(11) unsigned COMMENT '最后修改者ID',
-- 	`modify_time` datetime COMMENT '修改时间',
-- 	`create_id` int(11) unsigned COMMENT '上传者ID',
--  `create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
--     PRIMARY KEY (`id`)
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品表';

CREATE TABLE to_customer(
    "id" SERIAL PRIMARY KEY,
    "email" CHARACTER VARYING(100) DEFAULT NULL,
    "mobile" CHARACTER(11) DEFAULT NULL,
    "username" CHARACTER VARYING(50) NOT NULL,
    "password" CHARACTER VARYING(40) NOT NULL,
    "salt" CHARACTER(10) DEFAULT NULL,
    "create_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp(),
    "last_login" TIMESTAMP WITHOUT time ZONE
);
CREATE INDEX idx_customer_username ON to_customer USING btree(username);
COMMENT ON TABLE to_customer IS '客户（会员）信息表';
COMMENT ON COLUMN to_customer.email IS '邮箱';
COMMENT ON COLUMN to_customer.mobile IS '手机号码';
COMMENT ON COLUMN to_customer.username IS '会员名';

-- DROP TABLE IF EXISTS `to_customer`;
-- CREATE TABLE IF NOT EXISTS `to_customer` (
-- 	`id` int(10) NOT NULL AUTO_INCREMENT COMMENT '会员ID',
-- 	`email` varchar(100) NOT NULL COMMENT '邮箱',
-- 	`mobile` char(11) DEFAULT NULL COMMENT '手机号码',
-- 	`username` varchar(50) NOT NULL COMMENT '会员名',
-- 	`password` varchar(40) NOT NULL,
-- 	`salt` char(10) DEFAULT NULL COMMENT '混淆码',
-- 	`create_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
-- 	`last_login` bigint(20) DEFAULT NULL COMMENT '最后登录时间',
-- 	PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户（会员）信息表';
---------------------------学艺购商城表 end -----------------------------
---------------------------后台管理表 start ---------------------------
-- 内置分区表 (record) ,每月要新添加分区表。（或者每年也是行的。）
CREATE TABLE record(
    "id" serial,
    "table_id" integer NOT NULL,
    "table_name" CHARACTER VARYING(180) NOT NULL,
    "user_id" integer NOT NULL,
    "username" CHARACTER VARYING(18) NOT NULL,
    "action" CHARACTER VARYING(180) NOT NULL,
    "ip" inet NOT NULL,
    "record_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
) PARTITION BY RANGE(record_time);

COMMENT ON TABLE record IS '操作记录表-采用了内置分区表，按月分表';

COMMENT ON COLUMN record.table_id IS '操作表ID';

COMMENT ON COLUMN record.table_name IS '操作表名';

COMMENT ON COLUMN record.user_id IS '操作用户ID';

COMMENT ON COLUMN record.username IS '操作用户名';

COMMENT ON COLUMN record.action IS '操作动作';

COMMENT ON COLUMN record.ip IS '操作IP';

COMMENT ON COLUMN record.record_time IS '操作时间';

-- 创建分区(历史分区)
CREATE TABLE record_history PARTITION OF record FOR
VALUES
FROM
    ('0001-01-01') TO ('2021-03-01');

-- 创建索引
CREATE INDEX idx_record_history_rtime ON record_history USING btree(record_time);

CREATE INDEX idx_record_history_user_id ON record_history USING btree(user_id);

-- 创建当月日志分区表
CREATE TABLE record_202103 PARTITION OF record FOR
VALUES
FROM
    ('2021-03-01') TO ('2021-04-01');

-- 创建索引
CREATE INDEX idx_record_202103_rtime ON record_202103 USING btree(record_time);

CREATE INDEX idx_record_202103_user_id ON record_202103 USING btree(user_id);

/* 分区添加、解、恢复、删除 */
CREATE TABLE record_202104 PARTITION OF record FOR
VALUES
FROM
    ('2021-04-01') TO ('2021-05-01');

CREATE INDEX idx_record_202104_rtime ON record_202104 USING btree(record_time);

CREATE INDEX idx_record_202104_user_id ON record_202104 USING btree(user_id);

--解分区
ALTER TABLE
    record DETACH PARTITION record_202104;

-- 恢复-连接分区 
ALTER TABLE
    record ATTACH PARTITION record_202104 FOR
VALUES
FROM
    ('2021-04-01') TO ('2021-05-01');

--删除分区
DROP TABLE record_202104;

-- DROP TABLE IF EXISTS `to_record`;
-- CREATE TABLE IF NOT EXISTS `to_record` (
--   `id` int(100) unsigned NOT NULL AUTO_INCREMENT,
--   `table_id` int(10) unsigned NOT NULL COMMENT '操作表ID',
--   `table_name` varchar(180) NOT NULL COMMENT '操作表名',
--   `user_id` int(10) unsigned NOT NULL COMMENT '操作用户ID',
--   `username` varchar(16) NOT NULL COMMENT '操作用户名',
--   `action` varchar(180) NOT NULL COMMENT '操作动作',
--   `ip` varchar(39) NOT NULL COMMENT '操作IP',
--   `record_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
--   PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作记录表';
CREATE TABLE rights (
    "right_id" SERIAL PRIMARY KEY,
    "right_name" CHARACTER VARYING(30) DEFAULT NULL,
    "right_class" CHARACTER VARYING(30) DEFAULT NULL,
    "right_method" CHARACTER VARYING(30) DEFAULT NULL,
    "right_detail" CHARACTER VARYING(30) DEFAULT NULL
);

COMMENT ON TABLE rights IS '权限表';

INSERT INTO
    rights (
        right_id,
        right_name,
        right_class,
        right_method,
        right_detail
    )
VALUES
    (1, NULL, 'menus', 'index', NULL),
    (2, NULL, 'menus', 'edit', NULL),
    (3, NULL, 'menus', 'delete', NULL),
    (4, NULL, 'menus', 'create', NULL),
    (5, NULL, 'roles', 'index', NULL),
    (6, NULL, 'roles', 'create', NULL),
    (7, NULL, 'roles', 'edit', NULL),
    (8, NULL, 'roles', 'delete', NULL),
    (9, NULL, 'admins', 'index', NULL),
    (10, NULL, 'admins', 'create', NULL),
    (11, NULL, 'admins', 'edit', NULL),
    (12, NULL, 'admins', 'delete', NULL),
    (13, NULL, 'record', 'index', NULL),
    (14, NULL, 'nav', 'index', NULL),
    (15, NULL, 'nav', 'create', NULL),
    (16, NULL, 'nav', 'edit', NULL),
    (17, NULL, 'article', 'index', NULL),
    (18, NULL, 'article', 'create', NULL),
    (19, NULL, 'article', 'edit', NULL);

-- DROP TABLE IF EXISTS `to_rights`;
-- CREATE TABLE IF NOT EXISTS `to_rights` (
--   `right_id` tinyint(10) unsigned NOT NULL AUTO_INCREMENT,
--   `right_name` varchar(30) DEFAULT NULL,
--   `right_class` varchar(30) DEFAULT NULL,
--   `right_method` varchar(30) DEFAULT NULL,
--   `right_detail` varchar(10) DEFAULT NULL,
--   PRIMARY KEY (`right_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限表';
CREATE TABLE admins (
    id serial primary key,
    username CHARACTER VARYING(16) NOT NULL,
    "password" CHARACTER VARYING(40) NOT NULL,
    salt CHARACTER(10) NOT NULL,
    "email" CHARACTER VARYING(100) DEFAULT NULL,
    "mobile" CHARACTER(11) DEFAULT NULL,
    "role" smallint DEFAULT NULL,
    "status" bigint DEFAULT 0,
    "create_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp(),
    --不带时区
    -- create_time TIMESTAMP(6) WITH TIME ZONE DEFAULT clock_timestamp(), --带时区
    "last_login" TIMESTAMP WITHOUT time ZONE DEFAULT NULL
);

CREATE INDEX idx_admins_username ON admins USING btree(username);

CREATE INDEX idx_admins_email ON admins USING btree(email);

CREATE INDEX idx_admins_role ON admins USING btree(role);

COMMENT ON TABLE admins IS '后台管理角色组';

COMMENT ON COLUMN admins.id IS '自增主键ID';

COMMENT ON COLUMN admins.username IS '登录名';

COMMENT ON COLUMN admins.password IS '登录密码';

COMMENT ON COLUMN admins.salt IS '混淆码';

COMMENT ON COLUMN admins.email IS '邮箱';

COMMENT ON COLUMN admins.mobile IS '电话';

COMMENT ON COLUMN admins.role IS '角色组ID';

COMMENT ON COLUMN admins.status IS '是否冻结：0=正常，1=永久冻结，冻结时间';

COMMENT ON COLUMN admins.create_time IS '创建时间(不带时区)';

COMMENT ON COLUMN admins.last_login IS '最后登录时间(不带时区)';

INSERT INTO
    admins (
        "id",
        "username",
        "password",
        "salt",
        "email",
        "mobile",
        "role",
        "status",
        "create_time",
        "last_login"
    )
VALUES
    (
        1,
        'luck',
        'c2a3b691ee173bbaee19a5d6aae8c995507fa706',
        '25ee364a54',
        'luck@fmail.pro',
        '13428122341',
        1,
        0,
        '2008-08-18 18:58:13',
        '2018-08-18 18:58:18'
    );

-- DROP TABLE IF EXISTS `to_admins`;
-- CREATE TABLE IF NOT EXISTS `to_admins` (
--   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
--   `username` varchar(16) NOT NULL COMMENT '登录名',
--   `password` varchar(40) NOT NULL,
--   `salt` char(10) DEFAULT NULL COMMENT '混淆码',
--   `email` varchar(100) NOT NULL COMMENT '邮箱',
--   `mobile` char(11) DEFAULT NULL COMMENT '手机号码',
--   `role` smallint(5) unsigned DEFAULT NULL COMMENT '角色',
--   `status` bigint(20) DEFAULT '0' COMMENT '0=正常，1=永久冻结，冻结时间',
--   `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
--   `last_login` bigint(20) DEFAULT NULL COMMENT '最后登录时间',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `username` (`username`),
--   KEY `group` (`role`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='后台用户表';
CREATE TABLE roles (
    id serial primary key,
    name CHARACTER VARYING(20) NOT NULL,
    rights CHARACTER VARYING(255) DEFAULT NULL,
    "default" CHARACTER VARYING(50) DEFAULT NULL
);

-- 添加name索引
CREATE INDEX idx_roles_name ON roles USING btree(name);

COMMENT ON TABLE roles IS '后台管理角色组';

COMMENT ON COLUMN roles.id IS '自增主键';

COMMENT ON COLUMN roles.name IS '角色组名称';

COMMENT ON COLUMN roles.rights IS '角色组权限';

COMMENT ON COLUMN roles.default IS '角色组默认登录页';

INSERT INTO
    roles (id, name, rights, "default")
VALUES
    (1, 'root=>超级管理组', '', 'love/index');

-- DROP TABLE IF EXISTS `to_roles`;
-- CREATE TABLE IF NOT EXISTS `to_roles` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `name` varchar(20) NOT NULL,
--   `rights` varchar(255) DEFAULT NULL,
--   `default` varchar(50) DEFAULT NULL COMMENT '默认登录页',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `name` (`name`)
-- ) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理角色组表';
CREATE TABLE menus (
    id serial primary key,
    order_by smallint NOT NULL,
    class character varying(20) DEFAULT NULL,
    method character varying(20) DEFAULT NULL,
    name character varying(20) NOT NULL,
    level smallint DEFAULT 0,
    parent SMALLINT DEFAULT 0,
    icon CHARACTER VARYING(50) DEFAULT NULL,
    department CHARACTER VARYING(20) DEFAULT NULL,
    is_show boolean DEFAULT TRUE
);

COMMENT ON TABLE menus IS '后台菜单表';

comment on column menus.id is 'ID自增主键';

comment on column menus.order_by is '排序';

comment on column menus.class is '类';

comment on column menus.method is '方法';

comment on column menus.name is '菜单名字';

COMMENT ON COLUMN menus.level IS '菜单层级';

COMMENT ON COLUMN menus.parent IS '菜单父级';

COMMENT ON COLUMN menus.icon IS '菜单左侧小图标';

COMMENT ON COLUMN menus.department IS '菜单所属顶级';

COMMENT ON COLUMN menus.is_show IS '菜单是否显示：默认true显示，false不显示';

-- 导出  表 tokay.to_menus 结构
-- DROP TABLE IF EXISTS `to_menus`;
-- CREATE TABLE IF NOT EXISTS `to_menus` (
--     `id` tinyint(10) unsigned NOT NULL AUTO_INCREMENT,
--     `order_by` tinyint(2) unsigned NOT NULL COMMENT '排序',
--     `class` varchar(20) NOT NULL COMMENT '类',
--     `method` varchar(30) NOT NULL COMMENT '方法',
--     `name` varchar(20) NOT NULL COMMENT '菜单名字',
--     `level` tinyint(2) unsigned DEFAULT '0' COMMENT '菜单层级',
--     `parent` tinyint(10) unsigned DEFAULT '0' COMMENT '父级',
--     `icon` varchar(50) DEFAULT NULL COMMENT 'ICON',
--     `department` varchar(20) DEFAULT NULL COMMENT '所属顶级',
--     `is_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示：默认1显示，0不显示',
--     PRIMARY KEY (`id`)
-- ) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8 COMMENT = '后台菜单表';
INSERT INTO
    menus (
        id,
        order_by,
        class,
        method,
        name,
        level,
        parent,
        icon,
        department,
        is_show
    )
VALUES
    (
        1,
        1,
        'love',
        'index',
        '后台首页',
        1,
        0,
        'fa-desktop',
        '1',
        TRUE
    ),
    (
        2,
        8,
        '',
        '',
        '系统设置',
        1,
        0,
        'fa-cogs',
        '请选择',
        TRUE
    ),
    (
        3,
        1,
        'menus',
        'index',
        '菜单管理',
        2,
        2,
        'fa-folder',
        '2',
        TRUE
    ),
    (
        4,
        4,
        'record',
        'index',
        '操作日志',
        2,
        2,
        NULL,
        '2',
        TRUE
    ),
    (
        5,
        3,
        'roles',
        'index',
        '角色管理',
        2,
        2,
        'fa-key',
        '2',
        TRUE
    ),
    (
        6,
        2,
        'admins',
        'index',
        '后台用户',
        2,
        2,
        'ssssss',
        '2',
        TRUE
    ),
    (
        7,
        2,
        'nav',
        'index',
        '导航菜单',
        1,
        0,
        'fa-fire',
        '请选择',
        TRUE
    ),
    (
        8,
        2,
        'article',
        'index',
        '文章管理',
        1,
        0,
        'fa-leanpub',
        '请选择',
        TRUE
    );

---------------------------后台管理表 end ---------------------------