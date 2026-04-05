extends AttackComponentBulletBase
class_name AttackComponentBulletThreePea
## 三线射手攻击组件


## 边路补偿(0：正常，1：上路补偿，-1：下路补偿)
var bullet_border_compensation := 0

## 攻击检测射线区域
var attack_ray_coll_shape:Array[CollisionShape2D]

## 初始化三线射手攻击组件
func _ready() -> void:
	super()
	for area:Area2D in detect_component.get_children():
		attack_ray_coll_shape.append(area.get_child(0))
	if is_instance_valid(Global.main_game):
		_init_attack_component_bullet_three_pea(owner.row_col)


func _init_attack_component_bullet_three_pea(row_col:Vector2i):
	_judge_position_bullet_position(row_col)


func _shoot_bullet():
	for i in range(3):
		## 边路补偿补偿
		if (bullet_border_compensation == 1 and i == 0) or (bullet_border_compensation == -1 and i == 2):
			_create_bullte(0.3, 1)

		else:
			_create_bullte(0, i, true)

	## 攻击音效
	SoundManager.play_character_SFX(&"Throw")

func _create_bullte(await_time:float, i:int=1, change_y_target:bool=false):
	if await_time:
		await get_tree().create_timer(await_time).timeout
	var bullet: Bullet000Base = Global.bullet_registry.get_bullet_scenes(attack_bullet_type).instantiate()
	var bullet_paras: Dictionary = _build_three_pea_bullet_paras(i, change_y_target)
	bullet.init_bullet(bullet_paras)
	bullets.add_child(bullet)

	## 有偏移的为正常发射的子弹：再 tween 到对应行高
	if change_y_target and bullet is BulletLinear000Base:
		(bullet as BulletLinear000Base).change_y(markers_2d_bullet[0].global_position.y + (i - 1) * 100)


## 先走父类 get_bullet_paras（方向、可攻击状态、位置等），再按三线规则改 BulletLane
func _build_three_pea_bullet_paras(i: int, change_y_target: bool) -> Dictionary:
	var dirs: Array[Vector2] = detect_component.ray_area_direction
	var ray_idx: int
	if change_y_target:
		ray_idx = clampi(i, 0, maxi(0, dirs.size() - 1))
	else:
		ray_idx = clampi(1, 0, maxi(0, dirs.size() - 1))
	var ray_dir: Vector2 = Vector2.RIGHT if dirs.is_empty() else dirs[ray_idx]
	var bullet_paras: Dictionary = get_bullet_paras(markers_2d_bullet[0].global_position, ray_dir)
	if change_y_target:
		bullet_paras[Bullet000NormBase.E_InitParasAttr.BulletLane] = owner.row_col.x + i - 1
	else:
		bullet_paras[Bullet000NormBase.E_InitParasAttr.BulletLane] = owner.row_col.x
	return bullet_paras


## 初始化时根据位置决定子弹偏移：边路补偿
func _judge_position_bullet_position(row_col:Vector2i):
	if row_col.x == 0:
		bullet_border_compensation = 1
	elif row_col.x == Global.main_game.plant_cell_manager.row_col.x - 1:
		bullet_border_compensation = -1
	else:
		bullet_border_compensation = 0
