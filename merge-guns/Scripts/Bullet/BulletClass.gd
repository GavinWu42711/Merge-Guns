extends CharacterBody2D

class_name BulletClass

@export var bullet_resource:BulletResource

@export var bullet_hitbox:Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lifespan_timer()
	bullet_hitbox.body_entered.connect(object_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_slide()
	
func lifespan_timer() -> void:
	await get_tree().create_timer(bullet_resource.bullet_base_stats["bullet_lifespan"] * bullet_resource.bullet_stat_mults["bullet_lifespan_mult"]).timeout
	self.queue_free()
	
func object_hit(body:Node2D) -> void:
	if body is EnemyClass:
		body.enemy_hit.emit(bullet_resource.bullet_base_stats["bullet_damage"] * bullet_resource.bullet_stat_mults["bullet_damage_mult"],{})
