/*
resource "fmc_access_policies" "access_policy" {
  depends_on = [ data.fmc_devices.device ]
  name = "BFD_Test"
  # default_action = "block" # Cannot have block with base IPS policy
  default_action = "permit"

}
*/