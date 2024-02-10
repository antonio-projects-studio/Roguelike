extends KinematicBody2D
class_name Character, "res://Art/v1.1 dungeon crawler 16x16 pixel pack/heroes/knight/knight_idle_anim_f0.png"


const FRICTION: float = 0.1

export (int) var acceleration: int = 50
export (int) var max_speed: int = 50

var move_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")


func move() -> void:
	move_direction = move_direction.normalized()
	velocity += move_direction * acceleration
	velocity = velocity.limit_length(max_speed)


func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)
