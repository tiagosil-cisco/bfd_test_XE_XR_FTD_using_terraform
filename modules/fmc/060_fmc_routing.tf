resource "fmc_host_objects" "igw_xe" {
  count = local.json_input.sessions
  name  = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-INSIDE-GW"
  value = cidrhost(cidrsubnet(local.json_input.supernet_iosxe_fw, 8, count.index + local.json_input.index_start), 1)
}

resource "fmc_host_objects" "xe_loopbacks" {
  count = local.json_input.sessions
  name  = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-LOOPBACK-XE"
  value = cidrhost(local.json_input.supernet_loopback_xe, count.index + local.json_input.index_start)
}

resource "fmc_staticIPv4_route" "to_iosxe" {
  depends_on     = [fmc_device_subinterfaces.side_xe]
  count          = local.json_input.sessions
  device_id      = data.fmc_devices.device.id
  interface_name = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-INSIDE"
  metric_value   = 100
  selected_networks {
    id = fmc_host_objects.xe_loopbacks[count.index].id

  }
  gateway {
    object {
      id   = fmc_host_objects.igw_xe[count.index].id
      name = fmc_host_objects.igw_xe[count.index].name
      type = fmc_host_objects.igw_xe[count.index].type
    }
  }
}



resource "fmc_host_objects" "igw_xr" {
  count = local.json_input.sessions
  name  = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-OUTSIDE-GW"
  value = cidrhost(cidrsubnet(local.json_input.supernet_iosxr_fw, 8, count.index + local.json_input.index_start), 1)
}

resource "fmc_host_objects" "xr_loopbacks" {
  count = local.json_input.sessions
  name  = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-LOOPBACK-XR"
  value = cidrhost(local.json_input.supernet_loopback_xr, count.index + local.json_input.index_start)
}

resource "fmc_staticIPv4_route" "to_iosxr" {
  depends_on     = [fmc_device_subinterfaces.side_xr]
  count          = local.json_input.sessions
  device_id      = data.fmc_devices.device.id
  interface_name = "${local.json_input.VRF_PREFIX}${count.index + local.json_input.index_start}-OUTSIDE"
  metric_value   = 100
  selected_networks {
    id = fmc_host_objects.xr_loopbacks[count.index].id

  }
  gateway {
    object {
      id   = fmc_host_objects.igw_xr[count.index].id
      name = fmc_host_objects.igw_xr[count.index].name
      type = fmc_host_objects.igw_xr[count.index].type
    }
  }
}