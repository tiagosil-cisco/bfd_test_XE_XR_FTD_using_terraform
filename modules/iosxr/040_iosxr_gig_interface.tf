resource "iosxr_interface" "gig_interfaces" {
  depends_on                  = [iosxr_vrf.VRFs]
  count                       = local.json_input.sessions
  interface_name              = "${local.json_input.interface_type_xr}${local.json_input.interface_id_xr}.1${count.index + local.json_input.index_start}"
  shutdown                    = false
  encapsulation_dot1q_vlan_id = "1${count.index + local.json_input.index_start}"
  vrf                         = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}"
  ipv4_address                = cidrhost(cidrsubnet(local.json_input.supernet_iosxr_fw, 8, count.index + local.json_input.index_start), 1)
  ipv4_netmask                = "255.255.255.0"

}