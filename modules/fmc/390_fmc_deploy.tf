
resource "fmc_ftd_deploy" "deploy" {
  depends_on     = [fmc_device_subinterfaces.side_xe, fmc_device_subinterfaces.side_xr]
  device         = data.fmc_devices.device.id
  ignore_warning = true
  force_deploy   = false
}
