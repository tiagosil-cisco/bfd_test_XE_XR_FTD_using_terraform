resource "iosxe_bgp_address_family_ipv4_vrf" "bgp_vrfs" {
  depends_on = [iosxe_vrf.VRFs]
  count      = local.json_input.sessions
  asn        = local.json_input.bgp_asn_xe
  af_name    = "unicast"
  vrfs = [
    {
      name = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
    }
  ]
}

resource "iosxe_bgp_ipv4_unicast_vrf_neighbor" "bgp_vrf_neighbors" {
  depends_on             = [iosxe_bgp_address_family_ipv4_vrf.bgp_vrfs, iosxe_interface_loopback.loopbacks]
  count                  = local.json_input.sessions
  asn                    = local.json_input.bgp_asn_xe
  vrf                    = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
  ip                     = cidrhost(local.json_input.supernet_loopback_xr, count.index + local.json_input.index_start)
  remote_as              = local.json_input.bgp_asn_xr
  shutdown               = false
  update_source_loopback = count.index + local.json_input.index_start
  ebgp_multihop          = true
  ebgp_multihop_max_hop  = 10

  activate = true

}
