locals {
  anywhere      = "0.0.0.0/0"
  anywhere_ipv6 = "::/0"
  service_gateway_display_name = coalesce(
    var.label_prefix == "none" && var.service_gateway_display_name == "none" ? "service-gw-route" : null,
    var.label_prefix == "none" && var.service_gateway_display_name != "none" ? var.service_gateway_display_name : null,
    var.label_prefix != "none" && var.service_gateway_display_name == "none" ? "${var.label_prefix}-service-gw-route" : null,
    var.label_prefix != "none" && var.service_gateway_display_name != "none" ? "${var.label_prefix}-${var.service_gateway_display_name}" : null
  )
}
