extends Node2D

class_name RoomClass

@export var room_type:String

@export var entrance_spawn:Marker2D
@export var next_room_door:Area2D
@export var next_room:String = "normal_combat"

signal player_entered(player:Player)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_entered.connect(set_player_at_entrance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in next_room_door.get_overlapping_bodies():
		if body is Player:
			next_room_door_entered()
	
func next_room_door_entered() -> void:
	print("going to next room")
	if met_condition_to_leave():
		Dungeon.change_room.emit(next_room)

func set_player_at_entrance(player:Player) -> void:
	player.global_position = entrance_spawn.global_position
	
# Overwrite this function to implement extra conditions necessary for the player to leave the floor
func met_condition_to_leave() -> bool:
	return true
