resource "fmc_security_zone" "security_zones-inside" {
  depends_on     = [data.fmc_devices.device]
  count          = local.json_input.sessions
  name           = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-INSIDE"
  interface_mode = "ROUTED"
}

resource "fmc_security_zone" "security_zones-outside" {
  depends_on     = [data.fmc_devices.device]
  count          = local.json_input.sessions
  name           = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-OUTSIDE"
  interface_mode = "ROUTED"
}