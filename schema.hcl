# Schema for the app database
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

table "keywords" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "keyword" {
    null = false
    type = text
  }
  column "description" {
    null = true
    type = text
  }
  column "category" {
    null = true
    type = text
  }
  column "is_active" {
    null    = false
    type    = boolean
    default = true
  }
  column "created_at" {
    null    = false
    type    = timestamptz
    default = sql("now()")
  }
  primary_key {
    columns = [column.id]
  }
  index "idx_keywords_keyword" {
    columns = [column.keyword]
    unique  = true
  }
}

table "analytics" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "keyword_id" {
    null = false
    type = integer
  }
  column "date" {
    null = false
    type = date
  }
  column "mention_count" {
    null    = false
    type    = integer
    default = 0
  }
  column "sentiment_score" {
    null = true
    type = numeric(3,2)
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "fk_analytics_keyword" {
    columns     = [column.keyword_id]
    ref_columns = [table.keywords.column.id]
    on_delete   = CASCADE
  }
  index "idx_analytics_keyword_date" {
    columns = [column.keyword_id, column.date]
    unique  = true
  }
}

table "notifications" {
  schema = schema.public
  column "id" {
    null = false
    type = serial
  }
  column "mention_id" {
    null = false
    type = text
  }
  column "channel" {
    null = false
    type = text
  }
  column "sent_at" {
    null    = true
    type    = timestamptz
  }
  column "status" {
    null    = false
    type    = text
    default = "pending"
  }
  column "retry_count" {
    null    = false
    type    = integer
    default = 0
  }
  column "created_at" {
    null    = false
    type    = timestamptz
    default = sql("now()")
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "fk_notifications_mention" {
    columns     = [column.mention_id]
    ref_columns = [table.mentions.column.id]
    on_delete   = CASCADE
  }
  index "idx_notifications_mention_id" {
    columns = [column.mention_id]
  }
  index "idx_notifications_status" {
    columns = [column.status]
  }
}
