extends Node2D

class_name DungeonHandler

var current_room_type:String = "start"
var changing_scene:bool = false

# Packed scenes of all rooms to load
@onready var normal_combat_scene:PackedScene = preload("res://Scenes/Rooms/NormalCombat.tscn")
@onready var shop_scene:PackedScene =preload("res://Scenes/Rooms/Shop.tscn")
@onready var boss_scene:PackedScene =preload("res://Scenes/Rooms/Boss.tscn")
@onready var forge_scene:PackedScene = preload("res://Scenes/Rooms/Forge.tscn")
@onready var treasure_scene:PackedScene = preload("res://Scenes/Rooms/Treasure.tscn")
@onready var start_scene:PackedScene 

# Player scene to respawn after each scene
@onready var player_scene:PackedScene = preload("res://Scenes/Player/Player.tscn")

signal change_room

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_room.connect(spawn_new_room)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn_new_room(room_type:String = "normal_combat") -> void:
	if not changing_scene:
		changing_scene = true
		# Switch current room to the appropriate next room
		if room_type == "normal_combat":
			current_room_type = "normal_combat"
			get_tree().change_scene_to_packed(normal_combat_scene)
		elif room_type == "shop":
			current_room_type = "shop"
			get_tree().change_scene_to_packed(shop_scene)
		elif room_type == "boss":
			current_room_type = "boss"
			get_tree().change_scene_to_packed(boss_scene)
		elif room_type == "forge":
			current_room_type = "forge"
			get_tree().change_scene_to_packed(forge_scene)
		elif room_type == "treasure":
			current_room_type = "treasure"
			get_tree().change_scene_to_packed(treasure_scene)
				
		#Wait for the change in scene to be properly processed to avoid bugs
		await get_tree().process_frame
		
		var room_node:RoomClass = get_tree().current_scene
		# Spawn back in player; Player is removed when the scene is changed
		var player:Player = player_scene.instantiate()
		room_node.add_child(player)
		room_node.player_entered.emit(player)
		print(current_room_type)
		changing_scene = false
	
