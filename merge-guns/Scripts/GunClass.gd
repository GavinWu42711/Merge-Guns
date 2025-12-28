extends Node2D

class_name GunClass

"""
TO-DO:
	Add an option to increment by angle for single shot
	Change where complete_shot() gets its start_pos and target_pos
"""

@export var gun_resource:GunResource
var can_shoot:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func complete_shot() -> void:
	if can_shoot:
		can_shoot = false
		for burst in (gun_resource.gun_base_stats["gun_bursts"] + gun_resource.gun_stat_increases["gun_bursts_increase"]):
			var amount_to_shoot:int = gun_resource.gun_base_stats["gun_bullets_per_shot"] + gun_resource.gun_stat_increases["gun_bullets_per_shot_increase"]
			
			var spread:float = 1
			var initial_spread:float = 0
			
			if amount_to_shoot % 2 == 1:
				#First bullet is exactly in the middle (odd amount of bullets)
				initial_spread = 0
			else:
				#First bullet is slightly offset from the middle (even amount of bullets)
				initial_spread = spread / 2
			
			#Multi-shots comes out in a radial pattern. Even bullets always shift up while odd bullets always shift down;
			for shot in (amount_to_shoot):
				var new_target_pos:Vector2 = get_global_mouse_position()
				var start_pos:Vector2 = self.global_position
				if shot % 2 == 1:
					new_target_pos.y += initial_spread
					new_target_pos.y += spread * shot
					single_shot(start_pos, new_target_pos)
				else:
					new_target_pos.y -= initial_spread
					new_target_pos.y -= spread * shot
					single_shot(start_pos, new_target_pos)
				
					
			await get_tree().create_timer(gun_resource.gun_base_stats["gun_burst_cooldown"] + gun_resource.gun_stat_increases["gun_burst_cooldown_increase"]).timeout
		await get_tree().create_timer(gun_resource.gun_base_stats["gun_shot_cooldown"] + gun_resource.gun_stat_increases["gun_shot_cooldown_increase"]).timeout
		can_shoot = true

func single_shot(start_pos:Vector2, target_pos:Vector2) -> void:
	#Creating the bullet
	var bullet:BulletClass = gun_resource.bullet_scene.instantiate()
	bullet.bullet_resource = BulletResource.new()
	get_tree().root.add_child(bullet)
	
	#Setting up the transform of the bullet and it's movement
	bullet.global_position = start_pos
	bullet.look_at(target_pos)
	bullet.velocity = Vector2.RIGHT.rotated(bullet.rotation) * gun_resource.bullet_base_stats["bullet_speed"] * gun_resource.bullet_stat_mults["bullet_speed_mult"]
	
	#Setting up all the information the bullet needs
	bullet.bullet_resource.bullet_base_stats = gun_resource.bullet_base_stats
	bullet.bullet_resource.bullet_stat_mults = gun_resource.bullet_stat_mults
	bullet.bullet_resource.bullet_effects = gun_resource.bullet_effects
	
