module "app" {
    source = "./webapp_deployment"
    application_name = "example-webapp"
    application_version = "v.01"
    artifact_bucket = "aston-lecture.springboot.simple-artifacts"
}