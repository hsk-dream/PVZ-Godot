extends Node
class_name GIM_Other

@onready var game_item_manager: GameItemManager = %GameItemManager

## 放置在背景的游戏物品
@onready var game_items_in_bg: Node2D = %GameItemsInBg
@onready var canvas_layer_temp: CanvasLayer = %CanvasLayerTemp

#region 场景预制体
## 保龄球红线
var WALLNUT_BOWLING_STRIPE = load("res://scenes/item/game_scenes_item/mini_game_items/wallnut_bowling_stripe.tscn")
## 锤子
var HAMMER = load("res://scenes/item/game_scenes_item/mini_game_items/hammer.tscn")
#endregion

#region 道具
var wallnut_bowling_stripe:WallnutBowlingStripe
## 锤子
var hammer:Hammer
#endregion

func init_other_item():
	if game_item_manager.game_para.is_bowling_stripe:
		wallnut_bowling_stripe = WALLNUT_BOWLING_STRIPE.instantiate()
		game_items_in_bg.add_child(wallnut_bowling_stripe)
		wallnut_bowling_stripe.init_item(game_item_manager.game_para.plant_cell_col_j, game_item_manager.game_para.plant_cell_can_use)

	if game_item_manager.game_para.is_hammer:
		hammer = HAMMER.instantiate()
		canvas_layer_temp.add_child(hammer)
