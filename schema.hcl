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

table "products" {
  schema = schema.public
  column "id" {
    type = serial
  }
  column "name" {
    type = varchar(255)
  }
  column "description" {
    type = text
  }
  column "price" {
    type = decimal(10, 2)
  }
  column "stock" {
    type    = int
    default = 0
  }
  column "created_at" {
    type    = timestamptz
    default = sql("now()")
  }
  primary_key {
    columns = [column.id]
  }
  index "idx_products_name" {
    columns = [column.name]
  }
}

table "categories" {
  schema = schema.public
  column "id" {
    type = serial
  }
  column "name" {
    type = varchar(100)
  }
  column "slug" {
    type = varchar(100)
  }
  column "parent_id" {
    type = int
    null = true
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "fk_categories_parent" {
    columns     = [column.parent_id]
    ref_columns = [column.id]
    on_delete   = SET_NULL
  }
  index "idx_categories_slug" {
    columns = [column.slug]
    unique  = true
  }
}
