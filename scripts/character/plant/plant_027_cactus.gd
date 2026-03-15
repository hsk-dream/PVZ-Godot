extends Plant000Base
class_name Plant027Cactus

@export_group("动画状态")
@export var is_rise:= false
@onready var attack_component: AttackComponentBulletCactus = $AttackComponent


## 初始化正常出战角色信号连接
func ready_norm_signal_connect():
	super()
	signal_update_speed.connect(attack_component.owner_update_speed)

	attack_component.signal_change_is_attack.connect(
		## 可以攻击时禁用眨眼
		func(_value):
			is_rise = attack_component.detect_component.judge_zombie_in_sky()
			attack_component.on_cactus_update_is_rise(is_rise)
	)


## 起落动画开始，设置不能攻击
func anim_rise_start():
	attack_component.update_is_attack_factors(false, AttackComponentBase.E_IsAttackFactors.Anim)


## 起落动画结束，设置可以攻击
func anim_rise_end():
	attack_component.update_is_attack_factors(true, AttackComponentBase.E_IsAttackFactors.Anim)
	attack_component.update_bullet_can_attack_zombie_status(is_rise)
