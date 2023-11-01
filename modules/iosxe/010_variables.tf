
locals {
  json_input = jsondecode(file("${path.root}/input_vars.json")) // file that is sent by ICO
}