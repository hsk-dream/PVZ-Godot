extends Node
class_name DIM_GardenPlant
## 掉落管理器的子节点，掉落花园植物使用

## 掉落花园植物的父节点
@export var all_drop_garden_plant_parent: Node2D

func _ready() -> void:
	EventBus.subscribe("create_garden_plant", create_garden_plant)

## 掉落花园植物
func create_garden_plant(global_position_new_garden_plant:Vector2):
	var new_garden_plant:Present = SceneRegistry.PRESENT.instantiate()

	all_drop_garden_plant_parent.add_child(new_garden_plant)
	new_garden_plant.global_position = global_position_new_garden_plant
	SoundManager.play_other_SFX("chime")

