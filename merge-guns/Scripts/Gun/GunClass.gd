extends Node2D

class_name GunClass

"""
To do: Implement spread as a stat that can be affected
"""

@export var gun_info:GunResource
@export var gun_type:String = "all"
@export var bullet_spawnpoint:Marker2D

var can_shoot:bool = true

signal shoot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalUpgrades.get_upgrade.connect(update_upgrades)
	update_upgrades(gun_type)
	shoot.connect(complete_shot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func complete_shot() -> void:
	if can_shoot:
		can_shoot = false
		for burst in (gun_info.gun_base_stats["gun_bursts"] + gun_info.gun_stat_increases["gun_bursts_increase"]):
			var amount_to_shoot:int = gun_info.gun_base_stats["gun_bullets_per_shot"] + gun_info.gun_stat_increases["gun_bullets_per_shot_increase"]
			print(amount_to_shoot)
			
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
				var target_pos:Vector2 = get_global_mouse_position()
				var start_pos:Vector2 = bullet_spawnpoint.global_position
				if shot % 2 == 1:
					var angle = initial_spread
					angle += spread * shot
					single_shot(start_pos, target_pos, angle)
				else:
					var angle = -initial_spread
					angle -= spread * shot
					single_shot(start_pos, target_pos,angle)
				
					
			await get_tree().create_timer(gun_info.gun_base_stats["gun_burst_cooldown"] + gun_info.gun_stat_increases["gun_burst_cooldown_increase"]).timeout
		await get_tree().create_timer(gun_info.gun_base_stats["gun_shot_cooldown"] + gun_info.gun_stat_increases["gun_shot_cooldown_increase"]).timeout		
		can_shoot = true

#Assume the angle is in degrees
func single_shot(start_pos:Vector2, target_pos:Vector2, angle:float = 0) -> void:
	#Creating the bullet
	var bullet:BulletClass = gun_info.bullet_scene.instantiate()
	bullet.bullet_resource = BulletResource.new()
	get_tree().root.add_child(bullet)
	
	
	#Setting up the transform of the bullet and it's movement given a target position from a starting position
	bullet.global_position = start_pos
	bullet.look_at(target_pos)
	#Assume the vector from start_pos to target_pos as 0 degrees
	bullet.velocity = Vector2.RIGHT.rotated(bullet.rotation + deg_to_rad(angle)) * gun_info.bullet_base_stats["bullet_speed"] * gun_info.bullet_stat_mults["bullet_speed_mult"]
	
	
	
	#Setting up all the information the bullet needs
	bullet.bullet_resource.bullet_base_stats = gun_info.bullet_base_stats
	bullet.bullet_resource.bullet_stat_mults = gun_info.bullet_stat_mults
	bullet.bullet_resource.bullet_base_effects = gun_info.bullet_base_effects
	bullet.bullet_resource.bullet_upgraded_effects = gun_info.bullet_upgraded_effects

#Gets the upgrades from global ugprades and applies them
func update_upgrades(upgrade_gun_type:String) -> void:
	if upgrade_gun_type == gun_type or upgrade_gun_type == "all":
		var upgrades_to_gun_type:GunResource = GunResource.new()
		var upgrades_to_all:GunResource = GlobalUpgrades.gun_upgrades["all"]
		"""
		Dictionaries that affect upgrades:
			bullet stat mults
			bullet upgraded effects
			gun stat increase
			
		Base stats should generally not be changed
		"""
		
		if GlobalUpgrades.gun_upgrades.get(gun_type) and upgrade_gun_type != "all":
			upgrades_to_gun_type = GlobalUpgrades.gun_upgrades[upgrade_gun_type]
			
		for stat_mult_upgrade in upgrades_to_all.bullet_stat_mults.keys():
			# Need the minus one to get the proper total mult increase. Mults do not work exponentially and are additive
			gun_info.bullet_stat_mults[stat_mult_upgrade] = upgrades_to_gun_type.bullet_stat_mults[stat_mult_upgrade] - 1 + upgrades_to_all.bullet_stat_mults[stat_mult_upgrade]
		
		for effect_upgrade in  upgrades_to_all.bullet_upgraded_effects.keys():
			if upgrades_to_all.bullet_upgraded_effects[effect_upgrade] is bool:
				gun_info.bullet_upgraded_effects[effect_upgrade] = (upgrades_to_gun_type.bullet_upgraded_effects[effect_upgrade] or upgrades_to_all.bullet_upgraded_effects[effect_upgrade])
			else:
				gun_info.bullet_upgraded_effects[effect_upgrade] = upgrades_to_gun_type.bullet_upgraded_effects[effect_upgrade] + upgrades_to_all.bullet_upgraded_effects[effect_upgrade]
				
		for stat_increase in upgrades_to_all.gun_stat_increases.keys():
			gun_info.gun_stat_increases[stat_increase] = upgrades_to_gun_type.gun_stat_increases[stat_increase] + upgrades_to_all.gun_stat_increases[stat_increase]
