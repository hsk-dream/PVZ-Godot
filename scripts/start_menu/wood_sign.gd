extends Control
class_name wood_sign

@onready var label: Label = $TextureRect/Panel/Label



func _ready() -> void:
	label.text = Global.user_manager.curr_user_name
	Global.user_manager.signal_users_update.connect(_on_update_curr_user)


func _on_update_curr_user():
	label.text = Global.user_manager.curr_user_name
