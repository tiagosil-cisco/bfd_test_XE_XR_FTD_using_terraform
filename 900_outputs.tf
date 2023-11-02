locals {
  number_of_sessions                   = local.json_input.sessions
  remove_ftd_sub_interface_xe          = [for i in range(local.number_of_sessions) : "terraform state rm 'module.fmc.fmc_device_subinterfaces.side_xe[${i}]'"]
  remove_ftd_sub_interface_xe_complete = join("\n", local.remove_ftd_sub_interface_xe)
  remove_ftd_sub_interface_xr          = [for i in range(local.number_of_sessions) : "terraform state rm 'module.fmc.fmc_device_subinterfaces.side_xr[${i}]'"]
  remove_ftd_sub_interface_xr_complete = join("\n", local.remove_ftd_sub_interface_xr)
  remove_ftd_static_xr                 = [for i in range(local.number_of_sessions) : "terraform state rm 'module.fmc.fmc_staticIPv4_route.to_iosxr[${i}]'"]
  remove_ftd_static_xr_complete        = join("\n", local.remove_ftd_static_xr)
  remove_ftd_static_xe                 = [for i in range(local.number_of_sessions) : "terraform state rm 'module.fmc.fmc_staticIPv4_route.to_iosxe[${i}]'"]
  remove_ftd_static_xe_complete        = join("\n", local.remove_ftd_static_xe)
  add_static_xr                        = [for i in range(local.number_of_sessions) : "router static vrf ${local.VRF_PREFIX}${i + local.json_input.index_start} address-family ipv4 unicast ${cidrhost(local.json_input.supernet_loopback_xe, i + local.json_input.index_start)}/32 ${cidrhost(cidrsubnet(local.json_input.supernet_iosxr_fw, 8, i + local.json_input.index_start), 2)}"]
  add_static_xr_complete               = join("\n", local.add_static_xr)

  remove_ftd_static_routes_xe          = [for i in range(local.number_of_sessions) : "configure network static-routes ipv4 delete ${local.json_input.VRF_PREFIX}${i + local.json_input.index_start}-INSIDE ${cidrhost(local.json_input.supernet_loopback_xe, i + local.json_input.index_start)} 255.255.255.255 ${cidrhost(cidrsubnet(local.json_input.supernet_iosxe_fw, 8, i + local.json_input.index_start), 1)}"]
  remove_ftd_static_routes_xe_complete = join("\n", local.remove_ftd_static_routes_xe)

  remove_ftd_static_routes_xr          = [for i in range(local.number_of_sessions) : "configure network static-routes ipv4 delete ${local.json_input.VRF_PREFIX}${i + local.json_input.index_start}-OUTSIDE ${cidrhost(local.json_input.supernet_loopback_xr, i + local.json_input.index_start)} 255.255.255.255 ${cidrhost(cidrsubnet(local.json_input.supernet_iosxr_fw, 8, i + local.json_input.index_start), 1)}"]
  remove_ftd_static_routes_xr_complete = join("\n", local.remove_ftd_static_routes_xr)


  json_input = jsondecode(file("${path.root}/input_vars.json")) // file that is sent by ICO

}

resource "local_file" "ftd_rollback" {
  filename = "${path.module}/scripts_terraform_ftd_rollback.txt"
  content  = <<-EOT
  ${local.remove_ftd_sub_interface_xe_complete}
  ${local.remove_ftd_sub_interface_xr_complete}
  ${local.remove_ftd_static_xr_complete}
  ${local.remove_ftd_static_xe_complete}
  EOT
}

resource "local_file" "scripts_xr_add_static_routes" {
  filename = "${path.module}/scripts_xr_static_routes.txt"
  content  = <<-EOT
  ${local.add_static_xr_complete}

  EOT
}

resource "local_file" "scripts_ftd_remove_static_routes_xe" {
  filename = "${path.module}/scripts_ftd_remove_static_routes_xe.txt"
  content  = <<-EOT
  ${local.remove_ftd_static_routes_xe_complete}

  EOT
}

resource "local_file" "scripts_ftd_remove_static_routes_xr" {
  filename = "${path.module}/scripts_ftd_remove_static_routes_xr.txt"
  content  = <<-EOT
  ${local.remove_ftd_static_routes_xr_complete}

  EOT
}