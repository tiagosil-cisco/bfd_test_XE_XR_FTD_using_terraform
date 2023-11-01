resource "iosxr_vrf" "VRFs" {
  // depends_on = [ iosxe_bgp_ipv4_unicast_vrf_neighbor.bgp_vrf_neighbors ]
  count                       = local.json_input.sessions
  vrf_name                    = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
  address_family_ipv4_unicast = true
  rd_two_byte_as_as_number    = local.json_input.bgp_asn_xr
  rd_two_byte_as_index        = count.index + local.json_input.index_start
  address_family_ipv4_unicast_import_route_target_two_byte_as_format = [
    {
      as_number = local.json_input.bgp_asn_xr
      index     = "${count.index + local.json_input.index_start}"
      stitching = false
    },
    {
      as_number = local.json_input.bgp_asn_xe
      index     = "${count.index + local.json_input.index_start}"
      stitching = false
    }
  ]
  address_family_ipv4_unicast_export_route_target_two_byte_as_format = [
    {
      as_number = local.json_input.bgp_asn_xr
      index     = "${count.index + local.json_input.index_start}"
      stitching = false
    }
  ]
}
