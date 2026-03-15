extends ComponentNormBase
class_name ScaredyComponent


signal signal_scaredy_start
signal signal_scaredy_end
@onready var detect_component: DetectComponent = $DetectComponent

## 害怕时影响的节点
@export var scaredy_influence_components:Array[ComponentNormBase]

func _ready() -> void:
	super()
	detect_component.signal_can_attack.connect(func():signal_scaredy_start.emit())
	detect_component.signal_not_can_attack.connect(func():signal_scaredy_end.emit())

## 启用组件
func enable_component(is_enable_factor:E_IsEnableFactor):
	super(is_enable_factor)
	if is_enabling:
		detect_component.enable_component(E_IsEnableFactor.Scaredy)

## 禁用组件
func disable_component(is_enable_factor:E_IsEnableFactor):
	super(is_enable_factor)
	detect_component.disable_component(E_IsEnableFactor.Scaredy)
	signal_scaredy_end.emit()
