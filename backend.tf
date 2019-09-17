terraform {
  backend "remote" {
    organization = "marko"

    workspaces {
      name = "demo-tf-fargate"
    }
  }
  required_version = "~> 0.12.8"
}
