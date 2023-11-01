resource "iosxe_vrf" "VRFs" {
  count = local.json_input.sessions
  name  = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"

  rd                  = "${local.json_input.bgp_asn_xe}:${count.index + local.json_input.index_start}"
  address_family_ipv4 = true
  ipv4_route_target_import = [
    {
      value = "${local.json_input.bgp_asn_xe}:${count.index + local.json_input.index_start}"

    },
    {
      value = "${local.json_input.bgp_asn_xr}:${count.index + local.json_input.index_start}"
    }

  ]

  ipv4_route_target_export = [
    {
      value = "${local.json_input.bgp_asn_xe}:${count.index + local.json_input.index_start}"
    }
  ]
}