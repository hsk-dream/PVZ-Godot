extends Bullet000Base
class_name Bullet016CobCannon

var target_global_pos :Vector2
@onready var bomb_component: BombComponentNorm = %BombComponent
@onready var area_2d_bomb: Area2D = $BombComponent/Area2DBomb

func init_cannon(curr_target_global_pos:Vector2):
	self.target_global_pos = curr_target_global_pos
	z_index = 4000


func _ready() -> void:

	bullet_shadow.visible = false
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(body, ^"position:y", -1000, 0.8)
	await tween.finished

	await get_tree().create_timer(1, false).timeout
	global_position = target_global_pos
	bullet_shadow.visible = true
	await get_tree().create_timer(1, false).timeout

	## 移动爆炸检测框的y值
	if is_instance_valid(Global.main_game.main_game_slope):
		## 获取对应位置的斜面y相对位置
		var slope_y_first = Global.main_game.main_game_slope.get_all_slope_y(global_position.x)

		area_2d_bomb.position.y -= slope_y_first

	body.rotation_degrees = 90
	tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(body, ^"position:y", 0, 1)
	tween.tween_property(bullet_shadow, ^"modulate:a", 1.5, 0.8)
	tween.tween_property(bullet_shadow, ^"scale", Vector2(3.5, 3), 0.8)
	await tween.finished
	body.visible = false
	bomb_component.bomb_once()

	queue_free()
