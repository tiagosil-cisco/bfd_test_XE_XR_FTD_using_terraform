resource "iosxe_interface_ethernet" "gig_interfaces" {
  depends_on                  = [iosxe_vrf.VRFs]
  count                       = local.json_input.sessions
  type                        = local.json_input.interface_type_xe
  name                        = "${local.json_input.interface_id_xe}.${count.index + local.json_input.index_start}"
  encapsulation_dot1q_vlan_id = count.index + local.json_input.index_start
  shutdown                    = false
  //ipv4_address                = "10.41.${count.index + local.index_start}.1"
  ipv4_address      = cidrhost(cidrsubnet(local.json_input.supernet_iosxe_fw, 8, count.index + local.json_input.index_start), 1)
  ipv4_address_mask = "255.255.255.0"
  vrf_forwarding    = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
}
