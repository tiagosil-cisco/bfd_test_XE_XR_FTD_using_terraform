resource "iosxr_router_bgp_vrf" "bgp_vrf" {
  depends_on               = [iosxr_vrf.VRFs, iosxr_interface.loopbacks]
  count                    = local.json_input.sessions
  as_number                = local.json_input.bgp_asn_xr
  vrf_name                 = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
  rd_auto                  = false
  rd_two_byte_as_as_number = local.json_input.bgp_asn_xr
  rd_two_byte_as_index     = count.index + local.json_input.index_start
  bfd_minimum_interval     = local.json_input.bfd_minimum_interval
  bfd_multiplier           = local.json_input.bfd_multiplier


  neighbors = [
    {
      neighbor_address                = cidrhost(local.json_input.supernet_loopback_xe, count.index + local.json_input.index_start)
      remote_as                       = local.json_input.bgp_asn_xe
      bfd_fast_detect                 = true
      ebgp_multihop_maximum_hop_count = 10

      update_source = "Loopback${count.index + local.json_input.index_start}"

    }
  ]

}

resource "iosxr_router_bgp_vrf_address_family" "bgp_vrf_af" {
  depends_on = [iosxr_router_bgp_vrf.bgp_vrf]
  count      = local.json_input.sessions
  as_number  = local.json_input.bgp_asn_xr
  vrf_name   = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
  af_name    = "ipv4-unicast"
}


resource "iosxr_router_bgp_vrf_neighbor_address_family" "bgp_vrf_neighbors" {
  depends_on       = [iosxr_router_bgp_vrf_address_family.bgp_vrf_af, iosxr_router_bgp_vrf.bgp_vrf]
  count            = local.json_input.sessions
  as_number        = local.json_input.bgp_asn_xr
  vrf_name         = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
  neighbor_address = cidrhost(local.json_input.supernet_loopback_xe, count.index + local.json_input.index_start)
  af_name          = "ipv4-unicast"
  route_policy_in  = "PASS"
  route_policy_out = "PASS"
}