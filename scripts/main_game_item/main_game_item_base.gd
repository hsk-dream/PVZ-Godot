extends Node2D
## 主游戏道具基类
class_name MainGameItemBase

#region 主游戏道具基本属性，有则赋值
## 道具所在行
var lane:int = -1
## 道具所在植物格子
var plant_cell:PlantCell = null

#endregion
