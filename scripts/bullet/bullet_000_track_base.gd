extends Bullet000Base
class_name Bullet000TrackBase

## 敌人
var target_enemy:Character000Base = null
## 检测到敌人后的移动时间
var current_time:float = 0
## 下一帧的目标点
var next_point:Vector2
## 全局检测组件
var detect_component_global:DetectComponent

## 最终位置修正,目标位置为本体位置,本体与body有偏移
@export var target_pos_correct:Vector2 = Vector2(0, -40)
## 第一修正点的位置 按当前速度移动的秒数,由于每帧更新方向,更新频繁,因此改变方向非常快
@export var first_point_time:float = 10
## 追踪子弹初始化子弹属性
## [Enemy: Character000Base]: 敌人
func init_bullet(bullet_paras:Dictionary[E_InitParasAttr,Variant]):
	super(bullet_paras)
	z_index = 4000
	detect_component_global = Global.main_game.detect_component_global

	## 抛物线子弹初始化(子弹初始化之后)
	self.target_enemy = bullet_paras.get(E_InitParasAttr.Enemy, null)
	if not is_instance_valid(self.target_enemy):
		self.target_enemy = detect_component_global.update_enemy_track_bullet()


func _physics_process(delta: float) -> void:
	## 如果敌人死亡或敌人不存在
	if (is_instance_valid(target_enemy) and target_enemy.is_death) or not is_instance_valid(target_enemy):
		if is_instance_valid(detect_component_global.enemy_can_be_attacked) and not detect_component_global.enemy_can_be_attacked.is_death:
			target_enemy = detect_component_global.enemy_can_be_attacked
		else:
			target_enemy = detect_component_global.update_enemy_track_bullet()
		current_time = 0
		if not is_instance_valid(target_enemy):
			global_position += direction * delta * speed

			## 移动超过最大距离后销毁，部分子弹有限制,大部分子弹超过默认2000后删除
			if global_position.distance_to(start_pos) > max_distance:
				queue_free()

			return

	set_next_point(delta)
	body.look_at(next_point)
	global_position = global_position.move_toward(next_point, speed * delta)

func set_next_point(delta):
	current_time += delta
	var distance = global_position.distance_to(target_enemy.hurt_box_component.global_position + target_pos_correct)
	var all_time = distance / speed
	var t = min(current_time / all_time, 1)
	var start_control_point = direction * speed * first_point_time + global_position
	next_point = global_position.bezier_interpolate(start_control_point, target_enemy.hurt_box_component.global_position + target_pos_correct, target_enemy.hurt_box_component.global_position + target_pos_correct, t)
	direction = (next_point - global_position).normalized()
	#prints("子弹方向:", direction, "速度:", speed)
	#prints("当前全局位置", global_position, "第一控制点", start_control_point)

## 子弹与敌人碰撞
func _on_area_2d_attack_area_entered(area: Area2D) -> void:
	## 子弹还有攻击次数
	if max_attack_num != -1 and curr_attack_num < max_attack_num:
		if area.owner == target_enemy:
			attack_once(target_enemy)
	## 子弹无限穿透 TODO:这地方可能会有问题,不过一般没有无限穿透的追踪子弹
	if max_attack_num == -1:
		if area.owner == target_enemy:
			attack_once(target_enemy)
