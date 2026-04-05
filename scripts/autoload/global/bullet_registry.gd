extends Node
class_name BulletRegistry


enum BulletType{
	Null = 0,

	Bullet001Pea = 1,			## 豌豆
	Bullet002PeaSnow,		## 寒冰豌豆
	Bullet003Puff,			## 小喷孢子
	Bullet004Fume,			## 大喷孢子
	Bullet005PuffLongTime,	## 胆小菇孢子（和小喷孢子一样，不过修改存在持续距离）
	Bullet006PeaFire,		## 火焰豌豆
	Bullet007Cactus,		## 仙人掌尖刺
	Bullet008Star,			## 星星子弹

	Bullet009Cabbage,		## 卷心菜
	Bullet010Corn,			## 玉米
	Bullet011Butter,		## 黄油
	Bullet012Melon,			## 西瓜

	Bullet013Basketball,	## 篮球

	Bullet014CattailBullet,	## 香蒲子弹
	Bullet015WinterMelon,	## 冰瓜子弹

	Bullet016CobCannon,		## 玉米加农炮子弹


	Bullet1001Bowling,		## 保龄球
	Bullet1001BowlingBomb,	## 爆炸保龄球
	Bullet1001BowlingBig,	## 大保龄球

}


## 伤害种类
## 普通，穿透，真实
enum AttackMode {
	Norm, 			## 正常 按顺序对二类防具、一类防具、本体造成伤害
	Penetration, 	## 穿透 对二类防具造成伤害同时对一类防具造成伤害
	Real,			## 真实 不对二类防具造成伤害，直接对一类防具造成伤害
	BowlingFront,		## 保龄球正面
	BowlingSide,		## 保龄球侧面
	Hammer,			## 锤子

	}

@export var BulletTypeMap :Dictionary[BulletType, PackedScene]= {
	BulletType.Bullet001Pea : preload("res://scenes/bullet/bullet_001_pea.tscn"),
	BulletType.Bullet002PeaSnow : preload("res://scenes/bullet/bullet_002_pea_snow.tscn"),
	BulletType.Bullet003Puff : preload("res://scenes/bullet/bullet_003_puff.tscn"),
	BulletType.Bullet004Fume : preload("res://scenes/bullet/bullet_004_fume.tscn"),
	BulletType.Bullet005PuffLongTime : preload("res://scenes/bullet/bullet_005_puff_long_time.tscn"),
	BulletType.Bullet006PeaFire : preload("res://scenes/bullet/bullet_006_pea_fire.tscn"),
	BulletType.Bullet007Cactus : preload("res://scenes/bullet/bullet_007_cactus.tscn"),
	BulletType.Bullet008Star : preload("res://scenes/bullet/bullet_008_star.tscn"),

	BulletType.Bullet009Cabbage :preload("res://scenes/bullet/bullet_009_cabbage.tscn"),
	BulletType.Bullet010Corn :preload("res://scenes/bullet/bullet_010_corn.tscn"),
	BulletType.Bullet011Butter :preload("res://scenes/bullet/bullet_011_butter.tscn"),
	BulletType.Bullet012Melon :preload("res://scenes/bullet/bullet_012_melon.tscn"),

	BulletType.Bullet013Basketball :preload("res://scenes/bullet/bullet_013_basketball.tscn"),

	BulletType.Bullet014CattailBullet :preload("res://scenes/bullet/bullet_014_cattail_bullet.tscn"),
	BulletType.Bullet015WinterMelon :preload("res://scenes/bullet/bullet_015_winter_melon.tscn"),

	BulletType.Bullet016CobCannon :preload("res://scenes/bullet/bullet_016_cob_cannon.tscn"),
}

## 获取子弹场景方法
func get_bullet_scenes(bullet_type:BulletType) -> PackedScene:
	return BulletTypeMap.get(bullet_type)
