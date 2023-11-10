
resource "fmc_device_subinterfaces" "side_xe" {
  depends_on       = [fmc_security_zone.security_zones-inside]
  count            = local.json_input.sessions
  name             = "${local.json_input.interface_type_ftd}${local.json_input.interface_id_ftd_xe}"
  device_id        = data.fmc_devices.device.id
  subinterface_id  = count.index + local.json_input.index_start
  vlan_id          = count.index + local.json_input.index_start
  security_zone_id = fmc_security_zone.security_zones-inside[count.index].id
  ifname           = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-INSIDE"
  mtu              = 1500
  enabled          = true
  mode             = "NONE"
  ipv4_static_address = cidrhost(cidrsubnet(local.json_input.supernet_iosxe_fw, 8, count.index + local.json_input.index_start), 2)
  ipv4_static_netmask = 24

}


resource "fmc_device_subinterfaces" "side_xr" {
  depends_on       = [fmc_security_zone.security_zones-outside]
  count            = local.json_input.sessions
  name             = "${local.json_input.interface_type_ftd}${local.json_input.interface_id_ftd_xr}"
  device_id        = data.fmc_devices.device.id
  subinterface_id  = "1${count.index + local.json_input.index_start}"
  vlan_id          = "1${count.index + local.json_input.index_start}"
  security_zone_id = fmc_security_zone.security_zones-outside[count.index].id
  ifname           = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-OUTSIDE"
  mtu              = 1500
  enabled          = true
  mode             = "NONE"
  ipv4_static_address = cidrhost(cidrsubnet(local.json_input.supernet_iosxr_fw, 8, count.index + local.json_input.index_start), 2)
  ipv4_static_netmask = 24

}