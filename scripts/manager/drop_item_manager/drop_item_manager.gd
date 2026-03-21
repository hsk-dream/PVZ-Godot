extends MainGameSubManager
class_name DropItemManager
## 掉落道具管理器, 管理掉落金币、花盆
## 主游戏场景和花园场景使用

@onready var dim_garden_plant: DIM_GardenPlant = $DIM_GardenPlant
@onready var dim_coin: DIM_Coin = $DIM_Coin


func _ready() -> void:
	EventBus.subscribe("gold_magnet_attract_once", gold_magnet_attract_once)

func init_manager() -> void:
	pass

## 吸金磁 吸引金币一次
func gold_magnet_attract_once(target_pos:Vector2):
	for c in dim_coin.all_drop_coin_parent.get_children():
		if c is Coin:
			c.be_attract_gold_magnet(target_pos)


