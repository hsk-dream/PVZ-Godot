extends MainGameSubManager
## 游戏物品管理器
class_name GameItemManager

@onready var gim_brain: GIM_Brain = $GIM_Brain
@onready var gim_lawn_mover: GIM_LawnMover = $GIM_LawnMover
@onready var gim_other: GIM_Other = $GIM_Other


func init_manager() -> void:
	## 我是僵尸模式
	if game_para.is_zombie_mode:
		gim_brain.create_all_brain_on_zombie_mode()
	if game_para.is_lawn_mover:
		gim_lawn_mover.init_lawn_movers()
	gim_other.init_other_item()


## 开始下一轮游戏 模式管理器更新
func start_next_game_game_item_manager_update():
	if game_para.is_zombie_mode:
		gim_brain.create_all_brain_on_zombie_mode()
