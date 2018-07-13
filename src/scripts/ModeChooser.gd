extends Node2D

export (PackedScene) var server_scene
export (PackedScene) var client_scene

func _ready():
	for arg in OS.get_cmdline_args():
		if(arg == "--serve" or arg == "-s"):
			get_tree().change_scene_to(server_scene)

func _on_Button_pressed():
	var cur_ip = $ModeInput/Panel/TextEdit.text
	var cur_port_str = $ModeInput/Panel/TextEdit2.text
	var cur_port = int(float(cur_port_str))
	if(cur_port <= 2):
		$ModeInput/AcceptDialog.dialog_text = "Invalid port " + str(cur_port)
		$ModeInput/AcceptDialog.popup_centered()
		return
	var peer = NetworkedMultiplayerENet.new()
	var client_err = peer.create_client(cur_ip, cur_port)
	if(client_err != OK):
		$ModeInput/AcceptDialog.dialog_text = "Error connecting client!\n"
		if(client_err == ERR_ALREADY_IN_USE):
			$ModeInput/AcceptDialog.dialog_text += "Connection already in use!"
		elif(client_err == ERR_CANT_CREATE):
			$ModeInput/AcceptDialog.dialog_text += "Failed to create with IP " + cur_ip + "\n"
			$ModeInput/AcceptDialog.dialog_text += "Make sure it's in valid IPv4 or IPv6!\n"
		else:
			$ModeInput/AcceptDialog.dialog_text += "Unknown error: " + str(client_err)
		$ModeInput/AcceptDialog.popup_centered()
		return
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)