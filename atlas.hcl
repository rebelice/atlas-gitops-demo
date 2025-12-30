variable "db_url" {
  type    = string
  default = "postgres://localhost:5432/test?sslmode=disable"
}

env "local" {
  src = "file://schema.hcl"
  url = var.db_url
  dev = "docker://postgres/15/dev?search_path=public"
}

env "ci" {
  dev = "docker://postgres/15/dev?search_path=public"

  schema {
    src = "file://schema.hcl"
    repo {
      name = "app"
    }
  }

  lint {
    review = WARNING

    destructive {
      error = true
    }
  }
}

env "prod" {
  url = var.db_url
  src = "file://schema.hcl"
  dev = "docker://postgres/15/dev?search_path=public"

  schema {
    repo {
      name = "app"
    }
  }

  lint {
    review = ALWAYS

    destructive {
      error = true
    }
  }

  diff {
    skip {
      drop_schema = true
      drop_table  = true
    }
  }
}
