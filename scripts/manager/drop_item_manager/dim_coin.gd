extends Node
class_name DIM_Coin
## 掉落管理器的子节点，掉落金币使用


## 要求必须有这个金币显示label
@onready var coin_bank_label: CoinBankLabel = %CoinBankLabel
## 掉落金币的父节点
@export var all_drop_coin_parent: Node2D

func _ready() -> void:
	EventBus.subscribe("create_coin", create_coin)

## 生产金币,按概率生产，概率和为1,
## 概率顺序为 银币金币和钻石
func create_coin(probability:Array=[0.5, 0.5, 0], global_position_new_coin:Vector2=Vector2.ZERO, target_position:Vector2=Vector2(randf_range(-50, 50), randf_range(80, 90))):
	if not is_instance_valid(coin_bank_label):
		printerr("生成金币但没有coin_value_label")
		return
	coin_bank_label.update_label()
	var probability_sum: float = float(probability[0]) + float(probability[1]) + float(probability[2])
	assert(abs(probability_sum - 1.0) < 0.001, "概率和不为1")
	var r = randf()
	var new_coin:Coin
	if r < probability[0]:
		new_coin = SceneRegistry.COIN_SILVER.instantiate()
	elif r < probability[0] + probability[1]:
		new_coin = SceneRegistry.COIN_GOLD.instantiate()
	else:
		new_coin = SceneRegistry.COIN_DIAMOND.instantiate()
	all_drop_coin_parent.add_child(new_coin)
	new_coin.setup(coin_bank_label.marker_2d_coin_target.global_position)
	new_coin.global_position = global_position_new_coin
	## 抛物线发射金币
	new_coin.launch(target_position)
