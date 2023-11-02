resource "iosxe_bfd_template_multi_hop" "bfd_template" {
  name                             = "bfd_test"
  interval_milliseconds_min_tx     = local.json_input.bfd_minimum_interval
  interval_milliseconds_min_rx     = local.json_input.bfd_max_interval
  interval_milliseconds_multiplier = local.json_input.bfd_multiplier

}


resource "iosxe_bfd" "bfd_maps" {
  depends_on = [iosxe_vrf.VRFs]
  count      = local.json_input.sessions
  ipv4_both_vrfs = [
    {
      dst_vrf       = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
      dest_ip       = "${cidrhost(local.json_input.supernet_loopback_xr, count.index + local.json_input.index_start)}/32"
      src_vrf       = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
      src_ip        = "${cidrhost(local.json_input.supernet_loopback_xe, count.index + local.json_input.index_start)}/32"
      template_name = iosxe_bfd_template_multi_hop.bfd_template.name
    }
  ]

}