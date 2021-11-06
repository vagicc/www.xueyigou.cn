-- 学艺购表设计
-- 企业用户资质、设计师资质申请表：  、 
CREATE TABLE to_approve(
    "id" serial PRIMARY KEY,
    "mobile" CHARACTER(11) NOT NULL,
    "real_name" CHARACTER VARYING(120) NOT NULL,
    "is_student"  BOOLEAN DEFAULT FALSE,
    "student_certificate" CHARACTER VARYING(255) DEFAULT NULL,
    "identity_card" CHARACTER(18) NOT NULL,
    "identity_card_frontage" CHARACTER VARYING(255) DEFAULT NULL,
    "identity_card_verso" CHARACTER VARYING(255) DEFAULT NULL,
    "alipay" CHARACTER VARYING(120) DEFAULT NULL,
    "figure" MONEY DEFAULT NULL,
    "credit_code" CHARACTER(18) DEFAULT NULL,
    "business_license" CHARACTER VARYING(255) DEFAULT NULL,  
    "status" SMALLINT NOT NULL DEFAULT 0,
    "user_id" INTEGER NOT NULL,
    "user_type" SMALLINT NOT NULL,
    "modify_id" INTEGER DEFAULT NULL,
    "modify_time" TIMESTAMP WITHOUT time ZONE,
    "add_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()
);
CREATE INDEX idx_to_approve_mobile ON to_approve USING btree(mobile);
CREATE INDEX idx_to_approve_user_id ON to_approve USING btree(user_id);
CREATE INDEX idx_to_approve_user_type ON to_approve USING btree(user_type);
CREATE INDEX idx_to_approve_status ON to_approve USING btree(status);
COMMENT ON TABLE to_approve IS '资质申请表';
COMMENT ON COLUMN to_approve.id IS 'ID';
COMMENT ON COLUMN to_approve.mobile IS '本人实名认证手机号';
COMMENT ON COLUMN to_approve.real_name IS '用户真实名称';
COMMENT ON COLUMN to_approve.is_student IS '是否是学生';
COMMENT ON COLUMN to_approve.student_certificate IS '学生证';
COMMENT ON COLUMN to_approve.identity_card IS '身份证号码';
COMMENT ON COLUMN to_approve.identity_card_frontage IS '身份证正面照片';
COMMENT ON COLUMN to_approve.identity_card_verso IS '身份证反面照片';
COMMENT ON COLUMN to_approve.alipay IS '支付宝账号';
COMMENT ON COLUMN to_approve.figure IS '支付宝认证金额';
COMMENT ON COLUMN to_approve.credit_code IS '社会信用代码';
COMMENT ON COLUMN to_approve.business_license IS '营业执照照片';
COMMENT ON COLUMN to_approve.status IS '状态：0默认待审核，-1审核不通过，1审核通过';
COMMENT ON COLUMN to_approve.modify_id IS '后台审核修改ID';
COMMENT ON COLUMN to_approve.user_id IS '用户ID';
COMMENT ON COLUMN to_approve.user_type IS '用户类型：1普通用户；2设计师用户；3企业用户';
COMMENT ON COLUMN to_approve.modify_time IS '修改时间';
COMMENT ON COLUMN to_approve.add_time IS '添加时间';


-- 创建用户表与sessions表
CREATE TABLE users(
    "id" SERIAL PRIMARY KEY,
    "email" CHARACTER VARYING(100) DEFAULT NULL,
    "mobile" CHARACTER(11) DEFAULT NULL,
    "username" CHARACTER VARYING(50) NOT NULL,
    "realname" VARCHAR DEFAULT NULL,
    "user_type" SMALLINT NOT NULL DEFAULT 1,
    "password" CHARACTER VARYING(40) NOT NULL,
    "salt" CHARACTER(10) DEFAULT NULL,
    "create_time" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp(),
    "last_login" TIMESTAMP WITHOUT time ZONE DEFAULT clock_timestamp()  
);
CREATE INDEX idx_users_username ON users USING btree(username);
CREATE INDEX idx_users_user_type ON users USING btree(user_type);
COMMENT ON TABLE users IS '客户（会员）信息表';
COMMENT ON COLUMN users.email IS '邮箱';
COMMENT ON COLUMN users.mobile IS '手机号码';
COMMENT ON COLUMN users.username IS '会员名';
COMMENT ON COLUMN users.realname IS '真实姓名';
COMMENT ON COLUMN users.user_type IS '用户类型：1普通用户；2设计师用户；3企业用户';

CREATE TABLE sessions(
    "id" SERIAL PRIMARY KEY,
    "cookie" VARCHAR NOT NULL,
    "user_id" INTEGER NOT NULL REFERENCES users(id)
);

CREATE UNIQUE INDEX idx_sessions_cookie ON users (mobile);