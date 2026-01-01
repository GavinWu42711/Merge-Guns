extends Node2D

class_name RoomClass

@export var room_type:String

@export var entrance_spawn:Marker2D
@export var next_room_door:Area2D

#Script that controls the changing of rooms, queing of rooms, e.t.c
var dungeon_handler:DungeonHandler

signal player_enterred(player:Player)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_room_door.body_entered.connect(next_room_door_entered)
	player_enterred.connect(set_player_at_entrance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func next_room_door_entered() -> void:
	dungeon_handler.change_room.emit()

func set_player_at_entrance(player:Player) -> void:
	player.global_position = entrance_spawn.global_position
