resource "iosxr_interface" "loopbacks" {
  depends_on     = [iosxr_vrf.VRFs]
  count          = local.json_input.sessions
  interface_name = "Loopback${count.index + local.json_input.index_start}"

  shutdown     = false
  vrf          = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
  ipv4_address = cidrhost(local.json_input.supernet_loopback_xr, count.index + local.json_input.index_start)
  ipv4_netmask = "255.255.255.255"

}