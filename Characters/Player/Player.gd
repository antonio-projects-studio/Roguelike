extends Character
class_name Player


onready var sword: Node2D = get_node("Sword")
onready var sword_animation_player: AnimationPlayer = get_node("Sword/SwordAnimationPlayer")
onready var sword_hitbox: Hitbox = get_node("Sword/Node2D/Sprite/Hitbox")

func get_input() -> void:
	move_direction = Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		move_direction += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		move_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_right"):
		move_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		move_direction += Vector2.LEFT


func _process(_delta):
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()

	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true

	sword.rotation = mouse_direction.angle()
	sword_hitbox.knockback_direction = mouse_direction

	if mouse_direction.x > 0 and sword.scale.y == -1:
		sword.scale.y = 1
	elif mouse_direction.x < 0 and sword.scale.y == 1:
		sword.scale.y = -1

	if Input.is_action_just_pressed("ui_attack") and not sword_animation_player.is_playing():
		sword_animation_player.play("attack")

	
