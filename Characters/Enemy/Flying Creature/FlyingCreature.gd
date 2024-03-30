extends Enemy
class_name FlyingCreature, "res://Art/v1.1 dungeon crawler 16x16 pixel pack/enemies/flying creature/fly_anim_f0.png"

onready var hitbox: Hitbox = get_node("Hitbox")

func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()
