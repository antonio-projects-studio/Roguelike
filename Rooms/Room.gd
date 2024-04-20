extends Node2D


const SPAWN_EXPLOSION_SCENE: PackedScene = preload("res://Characters/Enemy/SpawnExplosion.tscn")
const ENEMY_SCENES: Dictionary = {
	"FLYING_CREATURE": preload("res://Characters/Enemy/Flying Creature/FlyingCreature.tscn")
}

var num_enemies: int

onready var tile_map: TileMap = get_node("Navigation2D/TileMap2")
onready var enterance: Node2D = get_node("Enterance")
onready var door_container: Node2D = get_node("Doors")
onready var enemy_position_container: Node2D = get_node("EnemyPositions")
onready var player_detector: Area2D = get_node("PLayerDetector")


func _ready() -> void:
	num_enemies = enemy_position_container.get_child_count()

	
func _open_doors() -> void:
	for door in door_container.get_children():
		door.open()

		
func _close_enterence() -> void:
	for entry_position in enterance.get_children():
		tile_map.set_cellv(tile_map.world_to_map(entry_position.global_position), 1)
		tile_map.set_cellv(tile_map.world_to_map(entry_position.global_position)+ Vector2.DOWN, 2)

		
func _spawn_enemies() -> void:
	for enemy_position in enemy_position_container.get_children():
		var enemy: KinematicBody2D = ENEMY_SCENES.FLYING_CREATURE.instance()
		var __ = enemy.connect("tree_exited", self, "_on_enemy_killed")
		var spawn_explosion: AnimatedSprite = SPAWN_EXPLOSION_SCENE.instance()
		enemy.global_position = enemy_position.global_position
		spawn_explosion.global_position = enemy_position.global_position
		call_deferred("add_child", enemy)
		call_deferred("add_child", spawn_explosion)

	
func _on_enemy_killed() -> void:
	num_enemies -= 1
	if num_enemies <= 0:
		_open_doors()
	

func _on_PLayerDetector_body_entered(body: KinematicBody2D) -> void:
	player_detector.queue_free()
	_close_enterence()
	_spawn_enemies()
	
