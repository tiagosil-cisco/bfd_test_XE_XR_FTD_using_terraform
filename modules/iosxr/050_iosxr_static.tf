/*
resource "iosxr_router_static_ipv4_unicast" "static" {
    count          = local.json_input.sessions
  prefix_address = cidrhost(local.json_input.supernet_loopback_xe, count.index + local.json_input.index_start)
  prefix_length  = 32

  vrfs = [
    {
      vrf_name = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"

      nexthop_addresses = [
        {
          address         = cidrhost(cidrsubnet(local.json_input.supernet_iosxr_fw, 8, count.index + local.json_input.index_start), 2)
        }
      ]
    }
  ]
}
*/