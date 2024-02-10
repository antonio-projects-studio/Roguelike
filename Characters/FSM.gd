extends Node
class_name FiniteStateMachine


var state: int = -1 setget set_state
var previous_state: int = -1
var states: Dictionary = {}

onready var parent: Character = get_parent()
onready var animation_player: AnimationPlayer = parent.get_node("AnimationPlayer")


func _add_state(new_state: String) -> void:
	states[new_state] = states.size()


func _enter_state(_previous_state: int, _new_state: int) -> void:
	pass


func _exite_state(_exited_state: int) -> void:
	pass


func set_state(new_state: int) -> void:
	_exite_state(state)
	previous_state = state
	state = new_state
	_enter_state(previous_state, state)


func _state_logic(_delta: float) -> void:
	pass


func _get_transition() -> int:
	return -1


func _physics_process(delta: float) -> void:
	if state != -1:
		_state_logic(delta)
		var transition = _get_transition()
		if transition != -1:
			set_state(transition)

