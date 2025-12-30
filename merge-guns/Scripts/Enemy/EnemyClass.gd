extends CharacterBody2D

class_name EnemyClass

@export var enemy_info:EnemyResource

var current_health:float

signal enemy_hit(damage:float,side_effects:Dictionary)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_hit.connect(got_hit)
	set_collision_layer_value(9,true)
	set_collision_mask_value(9,true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
func got_hit(damage:float,side_effects:Dictionary) -> void:
	print("enemy hit!")

func take_damage(damage:float) -> void:
	pass
