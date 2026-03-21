extends Node2D
class_name Pool

@onready var pool_drop: ColorRect = $Pool/PoolDrop

@onready var pool_base: Sprite2D = $PoolBase
@onready var pool: Sprite2D = $Pool
## 泳池白天图片
const POOL_BASE = preload("res://assets/image/background/pool_base.jpg")
const POOL = preload("res://assets/image/background/pool.jpg")

## 泳池黑夜图片
const POOL_BASE_NIGHT = preload("res://assets/image/background/pool_base_night.jpg")
const POOL_NIGHT = preload("res://assets/image/background/pool_night.jpg")


func init_pool(game_para:ResourceLevelData):
	match game_para.game_BG:
		ConstLevelData.GameBg.Pool:
			pool_base.texture = POOL_BASE
			pool.texture = POOL

		ConstLevelData.GameBg.Fog:
			pool_base.texture = POOL_BASE_NIGHT
			pool.texture = POOL_NIGHT

	if game_para.is_rain:
		pool_drop.visible = true
		var mat := pool_drop.material
		match game_para.game_BG:
			ConstLevelData.GameBg.Pool:
				mat.set("shader_parameter/drop_color", Color(0.0, 0.914, 0.941, 1.0))
			ConstLevelData.GameBg.Fog:
				mat.set("shader_parameter/drop_color", Color(0.0, 0.502, 0.773, 1.0))
	else:
		pool_drop.visible = false
