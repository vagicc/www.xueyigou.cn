table! {
    admins (id) {
        id -> Int4,
        username -> Varchar,
        password -> Varchar,
        salt -> Bpchar,
        email -> Nullable<Varchar>,
        mobile -> Nullable<Bpchar>,
        role -> Nullable<Int2>,
        status -> Nullable<Int8>,
        create_time -> Nullable<Timestamp>,
        last_login -> Nullable<Timestamp>,
    }
}

table! {
    linksnap (id) {
        id -> Int4,
        title -> Varchar,
        url -> Text,
        added -> Timestamp,
    }
}

table! {
    menus (id) {
        id -> Int4,
        order_by -> Int2,
        class -> Nullable<Varchar>,
        method -> Nullable<Varchar>,
        name -> Varchar,
        level -> Nullable<Int2>,
        parent -> Nullable<Int2>,
        icon -> Nullable<Varchar>,
        department -> Nullable<Varchar>,
        is_show -> Nullable<Bool>,
    }
}

table! {
    record (record_time) {
        id -> Int4,
        table_id -> Int4,
        table_name -> Varchar,
        user_id -> Int4,
        username -> Varchar,
        action -> Varchar,
        ip -> Inet,
        record_time -> Timestamp,
    }
}

table! {
    record_2021_10to12 (record_time) {
        id -> Int4,
        table_id -> Int4,
        table_name -> Varchar,
        user_id -> Int4,
        username -> Varchar,
        action -> Varchar,
        ip -> Inet,
        record_time -> Timestamp,
    }
}

table! {
    rights (right_id) {
        right_id -> Int4,
        right_name -> Nullable<Varchar>,
        right_class -> Nullable<Varchar>,
        right_method -> Nullable<Varchar>,
        right_detail -> Nullable<Varchar>,
    }
}

table! {
    roles (id) {
        id -> Int4,
        name -> Varchar,
        rights -> Nullable<Varchar>,
        default -> Nullable<Varchar>,
    }
}

table! {
    sessions (id) {
        id -> Int4,
        cookie -> Varchar,
        user_id -> Int4,
    }
}

table! {
    to_approve (id) {
        id -> Int4,
        mobile -> Bpchar,
        real_name -> Varchar,
        is_student -> Nullable<Bool>,
        student_certificate -> Nullable<Varchar>,
        identity_card -> Bpchar,
        identity_card_frontage -> Nullable<Varchar>,
        identity_card_verso -> Nullable<Varchar>,
        alipay -> Nullable<Varchar>,
        figure -> Nullable<Money>,
        credit_code -> Nullable<Bpchar>,
        business_license -> Nullable<Varchar>,
        status -> Int2,
        user_id -> Int4,
        user_type -> Int2,
        modify_id -> Nullable<Int4>,
        modify_time -> Nullable<Timestamp>,
        add_time -> Nullable<Timestamp>,
    }
}

table! {
    users (id) {
        id -> Int4,
        email -> Nullable<Varchar>,
        mobile -> Nullable<Bpchar>,
        username -> Varchar,
        realname -> Nullable<Varchar>,
        user_type -> Int2,
        password -> Varchar,
        salt -> Nullable<Bpchar>,
        create_time -> Nullable<Timestamp>,
        last_login -> Nullable<Timestamp>,
    }
}

joinable!(sessions -> users (user_id));

allow_tables_to_appear_in_same_query!(
    admins,
    linksnap,
    menus,
    record,
    record_2021_10to12,
    rights,
    roles,
    sessions,
    to_approve,
    users,
);
