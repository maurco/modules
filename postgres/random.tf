resource "random_pet" "dbname" {
  length = 1
}

resource "random_pet" "dbuser" {
  length = 1
}

resource "random_password" "dbpass" {
  length  = 32
  special = false
}
