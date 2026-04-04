extends Bullet000Base
class_name BulletLinear000Base
## 直线移动子弹基类

## 线性移动组件
@onready var movement_component: BulletMovementLinear = $MovementComponent

## 对僵尸敌人造成伤害,直线类子弹重写
func _attack_zombie(zombie:Zombie000Base):
	## 从后面攻击僵尸的子弹，正常伤害类型子弹攻击类型修改为真实
	if direction.x < 0 and bullet_mode ==BulletRegistry.AttackMode.Norm:
		## 攻击敌人
		zombie.be_attacked_bullet(attack_value,BulletRegistry.AttackMode.Real, true, trigger_be_attack_sfx)
	else:
		## 攻击敌人
		zombie.be_attacked_bullet(attack_value, bullet_mode, true, trigger_be_attack_sfx)


func _physics_process(delta: float) -> void:
	## 调用移动组件控制移动
	movement_component.physics_process_bullet_move(delta)

	## 移动超过最大距离后销毁，部分子弹有限制
	if global_position.distance_to(start_pos) > max_distance:
		queue_free()

## 改变y位置(三线调用)
func change_y(target_y:float):
	var tween = create_tween()
	var start_y = global_position.y
	tween.tween_method(func(y):
		global_position.y = y,
		start_y,
		target_y,
		0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

## 子弹与敌人碰撞,直线子弹检测是否有斜面,判断是否与斜面碰撞
func _on_area_2d_attack_area_entered(area: Area2D) -> void:
	## 线性子弹判断是否攻击到斜坡,非穿透子弹
	if area.owner is Slope:
		#if bullet_mode !=BulletRegistry.AttackMode.Penetration:
		var slope:Slope = area.owner
		## 如果方向与斜面法向量夹角小于90度
		if direction.dot(slope.normal_vector_slope) < 0:
			attack_once(null)
		return
	if area.owner is Character000Base:
		#print("碰撞到角色")
		super(area)

## 直线子弹先对壳类进行攻击
func get_first_be_hit_plant_in_cell(plant:Plant000Base)->Plant000Base:
	## shell
	if is_instance_valid(plant.plant_cell.plant_in_cell[CharacterRegistry.PlacePlantInCell.Shell]):
		return plant.plant_cell.plant_in_cell[CharacterRegistry.PlacePlantInCell.Shell]
	elif is_instance_valid(plant.plant_cell.plant_in_cell[CharacterRegistry.PlacePlantInCell.Norm]):
		return plant.plant_cell.plant_in_cell[CharacterRegistry.PlacePlantInCell.Norm]
	elif is_instance_valid(plant.plant_cell.plant_in_cell[CharacterRegistry.PlacePlantInCell.Down]):
		return plant.plant_cell.plant_in_cell[CharacterRegistry.PlacePlantInCell.Down]
	else:
		printerr("当前植物格子没有检测到可以攻击的植物")
		return null
