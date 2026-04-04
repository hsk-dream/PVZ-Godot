extends BulletMovementBase
class_name BulletMovementLinear
## 子弹移动组件 线性

## 每物理帧移动一次, 根节点调用
## return [bool]: 是否更新位置成功，若到达最后，更新失败
func physics_process_bullet_move(delta: float) -> bool:
	bullet.position += bullet.direction * bullet.speed * delta
	return true
