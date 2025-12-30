schema "public" {}

table "mentions" {
  schema = schema.public
  column "id" {
    null = false
    type = text
  }
  column "source" {
    null = false
    type = text
  }
  column "type" {
    null = false
    type = text
  }
  column "keyword" {
    null = false
    type = text
  }
  column "title" {
    null = false
    type = text
  }
  column "content" {
    null = true
    type = text
  }
  column "url" {
    null = false
    type = text
  }
  column "author" {
    null = true
    type = text
  }
  column "discovered_at" {
    null = false
    type = timestamptz
  }
  column "published_at" {
    null = true
    type = timestamptz
  }
  column "status" {
    null    = true
    type    = text
    default = "unread"
  }
  column "created_at" {
    null    = true
    type    = timestamptz
    default = sql("now()")
  }
  primary_key {
    columns = [column.id]
  }
  index "idx_mentions_discovered_at" {
    on {
      desc   = true
      column = column.discovered_at
    }
  }
  index "idx_mentions_url" {
    columns = [column.url]
  }
}
