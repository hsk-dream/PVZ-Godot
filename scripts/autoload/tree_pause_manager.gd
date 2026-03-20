extends Node

## 游戏暂停因素
enum E_PauseFactor {
	Menu,			## 菜单
	GameOver,		## 游戏结束
	ReChooseCard,	## 重新选卡
}

var curr_pause_factor: Dictionary = {}

func _update_pause_state() -> void:
	get_tree().paused = curr_pause_factor.values().any(func(v): return v)
	if get_tree().paused:
		print("暂停游戏")
	else:
		print("继续游戏")

## 开始场景树暂停
func start_tree_pause(pause_factor: E_PauseFactor) -> void:
	curr_pause_factor[pause_factor] = true
	_update_pause_state()

## 结束场景树暂停
func end_tree_pause(pause_factor: E_PauseFactor) -> void:
	curr_pause_factor[pause_factor] = false
	_update_pause_state()

## 清除所有暂停因素
func end_tree_pause_clear_all_pause_factors() -> void:
	curr_pause_factor.clear()
	_update_pause_state()
