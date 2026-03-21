extends Control
class_name DialogConfirm


signal confirmed

signal cancelled

@onready var panel: Panel = $Panel
@onready var label: Label = $Panel/BoxContainer/Label
@onready var button_confirm: BaseButton = $Panel/confirm
@onready var button_cancel: BaseButton = $Panel/cancel

func _ready() -> void:
	button_confirm.pressed.connect(_on_confirm_pressed)
	button_cancel.pressed.connect(_on_cancel_pressed)

func show_confirm(message: String) -> void:
	label.text = message
	visible = true
	mouse_filter = Control.MOUSE_FILTER_STOP
	#await get_tree().process_frame
	#_center_panel()
#
### 将面板居中到屏幕中央
#func _center_panel() -> void:
	##return
	#var viewport_size = get_viewport_rect().size
	#var panel_size = panel.size
	#panel.position = (viewport_size - panel_size*2) / 2



func hide_dialog() -> void:
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_confirm_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	hide_dialog()
	confirmed.emit()

func _on_cancel_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	hide_dialog()
	cancelled.emit()
