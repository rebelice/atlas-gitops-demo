schema "public" {}

table "users" {
  schema = schema.public
  column "id" {
    type = serial
  }
  column "name" {
    type = varchar(255)
  }
  column "email" {
    type = varchar(255)
  }
  column "created_at" {
    type    = timestamptz
    default = sql("now()")
  }
  primary_key {
    columns = [column.id]
  }
  index "idx_users_email" {
    columns = [column.email]
    unique  = true
  }
}

table "orders" {
  schema = schema.public
  column "id" {
    type = serial
  }
  column "user_id" {
    type = int
  }
  column "total" {
    type = decimal(10, 2)
  }
  column "status" {
    type    = varchar(50)
    default = "pending"
  }
  column "created_at" {
    type    = timestamptz
    default = sql("now()")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "fk_orders_user" {
    columns     = [column.user_id]
    ref_columns = [table.users.column.id]
    on_delete   = CASCADE
  }
  index "idx_orders_user_id" {
    columns = [column.user_id]
  }
}
