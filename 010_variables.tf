locals {

  sessions             = 2
  index_start          = 100
  bfd_minimum_interval = 300
  bfd_multiplier       = 4
  ospf_process         = 2


  VRF_PREFIX        = "BLUE"
  supernet_iosxe_fw = "10.41.0.0/16"
  supernet_iosxr_fw = "10.42.0.0/16"


  //IOS-XR details
  bgp_asn_xr           = 65300
  supernet_loopback_xr = "10.30.42.0/24"

  //IOS-XE details
  bgp_asn_xe           = 65321
  interface_type_xe    = "GigabitEthernet"
  interface_id_xe      = "0/0/5"
  supernet_loopback_xe = "10.30.41.0/24"

  //FMC Details
  interface_type_ftd  = "Ethernet"
  interface_id_ftd_xe = "1/7"
  interface_id_ftd_xr = "1/8"

  routers = [
    {
      name = "ROUTER-1"
      host = "10.1.1.1"
    },
    {
      name = "ROUTER-2"
      host = "10.1.1.2"
    },
  ]

}