terraform {

  required_providers {
    iosxe = {
      source = "CiscoDevNet/iosxe"
    }
    iosxr = {
      source = "CiscoDevNet/iosxr"

    }
    fmc = {
      source = "CiscoDevNet/fmc"
    }

  }
}
provider "iosxe" {
  username = "admin"
  password = "C!sco123"
  url      = "https://10.0.255.113"
}


provider "iosxr" {
  username = "cisco"
  password = "C1sco123"
  host     = "10.30.0.2:57344"
}

provider "fmc" {
  fmc_username             = "admin"
  fmc_password             = "Dov3tail!"
  fmc_host                 = "10.0.10.36"
  fmc_insecure_skip_verify = true
}