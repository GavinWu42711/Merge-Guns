extends CharacterBody2D

class_name EnemyClass

@export var enemy_info:EnemyResource

@export var attack_hitbox:Area2D

var current_health:float

signal enemy_hit(damage:float,side_effects:Dictionary)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_hit.connect(got_hit)
	set_collision_layer_value(9,true)
	set_collision_mask_value(9,true)
	current_health = enemy_info.base_stats[enemy_info.base_stats_enum.HEALTH] * enemy_info.stat_mults[enemy_info.stat_mults_enum.HEALTH_MULT]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_attack()
		
func got_hit(damage:float,side_effects:Dictionary) -> void:
	if side_effects:
		#Based on special effects from the bullets that inflicts something on the enemy
		pass
	take_damage(damage)

func take_damage(damage:float) -> void:
	current_health -= damage
	if current_health <= 0:
		current_health = 0
		die()

func die() -> void:
	#if special_effect: do something
	self.queue_free()
	
func check_attack_hitbox() -> void:
	var bodies = attack_hitbox.get_overlapping_bodies()
	if bodies:
		for body in bodies:
			if body is Player:
				object_hit(body)

func object_hit(node:Node2D) -> void:
	node.player_hit.emit(enemy_info.base_stats[enemy_info.base_stats_enum.DAMAGE] * enemy_info.stat_mults[enemy_info.stat_mults_enum.DAMAGE_MULT],{})

func move_and_attack() -> void:
	move()
	check_attack_hitbox()

func move() -> void:
	pass
