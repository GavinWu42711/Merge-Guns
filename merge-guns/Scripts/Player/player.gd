extends CharacterBody2D

class_name Player

const SPEED = 300.0

@onready var gun:GunClass = $Gun
@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D

var max_health:float = 100
var current_health:float

var invincibility_frame_length:float = 0.25
var invincible:bool = false

signal player_hit(damage:float, special_effects:Dictionary)

func _ready() -> void:
	player_hit.connect(got_hit)
	current_health = max_health

func _physics_process(delta: float) -> void:
	
	Global.player_pos = self.global_position
	
	look_at(get_global_mouse_position())
	
	
	velocity.x = Input.get_axis("left","right") * SPEED 
	velocity.y = Input.get_axis("up","down") * SPEED 
	
	if Input.is_action_just_pressed("shoot"):
		gun.shoot.emit()
	

	move_and_slide()

func got_hit(damage:float, special_effects:Dictionary) -> void:
	#if special_effects: do something
	take_damage(damage)

func take_damage(damage:float) -> void:
	if not invincible:
		invincible = true
		invincibility_timeout()
		current_health -= damage
		if current_health <= 0:
			current_health = 0
			die()
	else:
		pass

func die() -> void:
	#self.queue_free()
	print("player dead")

func invincibility_timeout() -> void:
	await get_tree().create_timer(invincibility_frame_length).timeout
	invincible = false
