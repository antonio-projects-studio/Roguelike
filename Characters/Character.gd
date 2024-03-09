extends KinematicBody2D
class_name Character, "res://Art/v1.1 dungeon crawler 16x16 pixel pack/heroes/knight/knight_idle_anim_f0.png"


const FRICTION: float = 0.1

export (int) var hp: int = 2
export (int) var acceleration: int = 50
export (int) var max_speed: int = 50

var move_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var state_machine: Node = get_node("FiniteStateMachine")


func move() -> void:
	move_direction = move_direction.normalized()
	velocity += move_direction * acceleration
	velocity = velocity.limit_length(max_speed)


func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)


func take_damage(dam: int, dir: Vector2, force: int) -> void:
	hp -= dam
	if hp > 0:
		state_machine.set_state(state_machine.states.hurt)
		velocity += dir * force
	else:
		state_machine.set_state(state_machine.states.dead)
		velocity += dir * force * 2

