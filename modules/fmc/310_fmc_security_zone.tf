resource "fmc_security_zone" "security_zones-inside" {
  count          = local.json_input.sessions
  name           = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-INSIDE"
  interface_mode = "ROUTED"
}

resource "fmc_security_zone" "security_zones-outside" {
  count          = local.json_input.sessions
  name           = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-OUTSIDE"
  interface_mode = "ROUTED"
}