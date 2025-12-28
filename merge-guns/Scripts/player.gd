extends CharacterBody2D


const SPEED = 300.0

@onready var gun:GunClass = $Gun


func _physics_process(delta: float) -> void:
	
	look_at(get_global_mouse_position())
	
	
	velocity.x = Input.get_axis("left","right") * SPEED 
	velocity.y = Input.get_axis("up","down") * SPEED 
	
	if Input.is_action_just_pressed("shoot"):
		gun.shoot()
	

	move_and_slide()
