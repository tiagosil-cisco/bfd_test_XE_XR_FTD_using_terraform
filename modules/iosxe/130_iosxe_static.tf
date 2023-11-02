resource "iosxe_static_route_vrf" "static" {
  count = local.json_input.sessions
  vrf   = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
  routes = [
    {
      prefix = cidrhost(local.json_input.supernet_loopback_xr, count.index + local.json_input.index_start)
      mask   = "255.255.255.255"
      next_hops = [
        {
          next_hop = cidrhost(cidrsubnet(local.json_input.supernet_iosxe_fw, 8, count.index + local.json_input.index_start), 2)
        }
      ]
    }
  ]
}