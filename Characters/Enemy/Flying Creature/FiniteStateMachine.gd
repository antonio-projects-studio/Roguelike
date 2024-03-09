extends FiniteStateMachine


func _init() -> void:
	_add_state("chase")


func _ready() -> void:
	set_state(states.chase)


func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.chase:
			animation_player.play("fly")


func _state_logic(_delta: float) -> void:
	match state:
		states.chase:
			parent.chase()
			parent.move()

