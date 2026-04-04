extends Node2D
class_name BulletMovementBase
## 子弹移动组件基类
## 移动组件不会自己控制子弹移动，由子弹根节点调用其对应的方法，实际上是对移动相关的数据进行封装

var bullet:Bullet000Base

func _ready() -> void:
	bullet = owner as Bullet000Base


## 每物理帧移动一次, 根节点调用
## return [bool]: 是否更新位置成功，若到达最后，更新失败
func physics_process_bullet_move(_delta: float) -> bool:
	return true

