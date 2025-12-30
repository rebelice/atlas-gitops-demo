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
