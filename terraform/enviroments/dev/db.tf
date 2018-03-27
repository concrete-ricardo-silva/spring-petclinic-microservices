resource "google_sql_database_instance" "master" {
  name             = "pet-clinic"
  database_version = "MYSQL_5_6"
  region           = "us-central"

  settings {
    tier = "db-n1-standard-1"
  }
}

resource "google_sql_database" "users" {
  name      = "users-db"
  instance  = "${google_sql_database_instance.master.name}"
  charset   = "latin1"
  collation = "latin1_swedish_ci"
}
