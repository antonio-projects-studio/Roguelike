extends Navigation2D


const SPAWN_ROOMS: Array = [preload("res://Rooms/Room0.tscn"), preload("res://Rooms/Room1.tscn")]
const INTERMIDIATE_ROOMS: Array = []
const END_ROOMS: Array = []
const TILE_SIZE: int = 16
const FLOOR_TILE_INDEX: int = 14
const RIGHT_WALL_TILE_INDEX: int = 5
const LEFT_WALL_TILE_INDEX: int = 6

export(int) var num_levels: int = 5

onready var player: KinematicBody2D = get_parent().get_node("Player")


func _ready() -> void:
	_spawn_rooms()
	
func _spawn_rooms() -> void:
	var previous_room: Node2D
	for i in num_levels:
		var room: Node2D
		if i == 0:
			room = SPAWN_ROOMS[randi() % SPAWN_ROOMS.size()].instance()
		add_child(room)
		previous_room = room
