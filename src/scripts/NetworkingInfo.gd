extends Node

signal ip_change(new_ip)
signal port_change(new_port)

var ip = "" setget _set_ip
var port = 3334 setget _set_port

func _set_ip(iip):
	ip = iip
	emit_signal("ip_change", iip)

func _set_port(iport):
	port = iport
	emit_signal("port_change", iport)