extends MainGameItemBase
class_name BrainOnZombieMode
## 我是僵尸模式下的脑子

@onready var area_2d_detect: Area2D = $Area2DDetect

@onready var drop_item_component: DropItemComponent = %DropItemComponent
@onready var brain_body: BrainBody = $BrainBody

@export var max_hp:= 100
var curr_hp :int = 100

## 第一格的植物格子，屋顶时移动y
var first_plant_cell:PlantCell
## 是否已经死亡
var is_death:=false

## 脑子死亡信号
signal signal_brain_death

func _ready() -> void:
	curr_hp = max_hp
	## 斜面与水平面的差值
	var diff_slope_flat:float = 0
	if is_instance_valid(first_plant_cell):
		#await get_tree().process_frame
		diff_slope_flat = first_plant_cell.position.y
	position.y += diff_slope_flat
	area_2d_detect.position.y -= diff_slope_flat

## 初始化脑子
func init_brain(curr_first_plant_cell:PlantCell):
	first_plant_cell = curr_first_plant_cell
	lane = first_plant_cell.row_col.x

## 被攻击一次掉血
func be_attack_once(attack_value:int=25):
	_hp_loss(attack_value)

## 被压扁
func be_flattened():

	brain_body.be_flattened_body()
	hp_loss_to_death()

## 掉血至死亡
func hp_loss_to_death():
	_hp_loss(curr_hp)

## 掉血
func _hp_loss(attack_value:int=25):
	curr_hp -= attack_value
	if curr_hp <= 0:
		_brain_death()

## 死亡
func _brain_death():
	if is_death:
		return

	is_death = true
	drop_item_component.drop_coin()
	signal_brain_death.emit()
	queue_free()

