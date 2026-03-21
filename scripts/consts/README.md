# `scripts/consts/`

本目录存放**全局可引用的枚举与关卡相关常量**，通过 `class_name` 在任意脚本中直接使用类型名，无需 `preload` 路径。

## 文件说明

| 文件 | `class_name` | 内容概要 |
|------|----------------|----------|
| `const_level_data.gd` | `ConstLevelData` | 关卡数据配套：背景 `GameBg`、BGM `GameBGM` 与路径表、出怪/卡槽/罐子模式枚举及纹理、音频等常量映射。被 `ResourceLevelData`（`level_data.gd`）等引用。 |
| `enums_character.gd` | `EnumsCharacter` | 植物类型、僵尸类型、行类型等与角色相关的枚举。 |
| `enums_main_scene.gd` | `EnumsMainScene` | 主流程场景标识 `MainScenes`（主游戏、选关、花园等）。 |
| `enums_bullet.gd` | `EnumsBullet` | 子弹相关枚举。 |
| `enums_item.gd` | `EnumsItem` | 物品相关枚举，目前没有，后续可能删除。 |

## 使用方式

在脚本中直接写类型或枚举成员，例如：

```gdscript
var bg: ConstLevelData.GameBg = ConstLevelData.GameBg.Pool
var scene: EnumsMainScene.MainScenes = EnumsMainScene.MainScenes.ChooseLevelAdventure
```

新增枚举或常量时，优先放在语义对应的文件中；若属于「整局关卡规则」且与 `ResourceLevelData` 强相关，放在 `ConstLevelData` 中。
