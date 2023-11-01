/*
resource "iosxe_ospf_vrf" "ospf" {
  depends_on = [iosxe_vrf.VRFs]
  count      = local.sessions
  process_id = count.index + local.index_start
  vrf        = "${local.VRF_PREFIX}${count.index + local.index_start}"
  network = [
    {
      ip       = "0.0.0.0"
      wildcard = "255.255.255.255"
      area     = "0"
    }
  ]
}

resource "iosxe_interface_ospf" "int_ospf" {
  depends_on = [ iosxe_interface_ethernet.gig_interfaces ]
  count                       = local.sessions
  type                        = local.interface_type_xe
  name                        = "${local.interface_id_xe}.${count.index + local.index_start}"
  //mtu_ignore                  = false
  network_type_point_to_point = true
}
*/