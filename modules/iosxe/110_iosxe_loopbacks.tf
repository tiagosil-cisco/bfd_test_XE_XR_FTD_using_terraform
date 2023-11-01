resource "iosxe_interface_loopback" "loopbacks" {
  depends_on     = [iosxe_vrf.VRFs]
  count          = local.json_input.sessions
  name           = count.index + local.json_input.index_start
  vrf_forwarding = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
  shutdown       = false
  //ipv4_address      = "10.30.41.${count.index + local.index_start}"
  ipv4_address      = cidrhost(local.json_input.supernet_loopback_xe, count.index + local.json_input.index_start)
  ipv4_address_mask = "255.255.255.255"
}