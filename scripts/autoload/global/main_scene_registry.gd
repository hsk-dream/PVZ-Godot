extends Node
class_name MainSceneRegistry


## 加载场景
enum MainScenes{
	MainGameFront,
	MainGameBack,
	MainGameRoof,

	StartMenu = 100,
	ChooseLevelAdventure,
	ChooseLevelMiniGame,
	ChooseLevelPuzzle,
	ChooseLevelSurvival,
	ChooseLevelCustom,

	Garden = 200,
	Almanac,
	Store,

	Null = 999,
}
@export var MainScenesMap = {
	MainScenes.MainGameFront: "res://scenes/main/MainGame01Front.tscn",
	MainScenes.MainGameBack: "res://scenes/main/MainGame02Back.tscn",
	MainScenes.MainGameRoof: "res://scenes/main/MainGame03Roof.tscn",

	MainScenes.StartMenu: "res://scenes/main/01StartMenu.tscn",
	MainScenes.ChooseLevelAdventure: "res://scenes/main/02AdventureChooesLevel.tscn",
	MainScenes.ChooseLevelMiniGame: "res://scenes/main/03MiniGameChooesLevel.tscn",
	MainScenes.ChooseLevelPuzzle: "res://scenes/main/04PuzzleChooesLevel.tscn",
	MainScenes.ChooseLevelSurvival: "res://scenes/main/05SurvivalChooesLevel.tscn",
	MainScenes.ChooseLevelCustom: "res://scenes/main/06CustomChooesLevel.tscn",

	MainScenes.Garden: "res://scenes/main/10Garden.tscn",
	MainScenes.Almanac: "res://scenes/main/11Almanac.tscn",
	MainScenes.Store: "res://scenes/main/12Store.tscn",
}

## 场景僵尸的行类型
@export var ZombieRowTypewithMainScenesMap:Dictionary[MainScenes, CharacterRegistry.ZombieRowType] = {
	MainScenes.MainGameFront:CharacterRegistry.ZombieRowType.Land,
	MainScenes.MainGameBack:CharacterRegistry.ZombieRowType.Both,
	MainScenes.MainGameRoof:CharacterRegistry.ZombieRowType.Land,
}
