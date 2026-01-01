extends Resource

class_name GunResource

"""
To-do: Implement spread as something that can impact the gun
"""

#Starting stats of the bullet for a gun
@export var bullet_base_stats:Dictionary = {
	"bullet_speed":float(400),
  	"bullet_damage":float(10),
	"bullet_lifespan":float(5),
}

#Multipliers on the bullet for a gun from upgrades
@export var bullet_stat_mults:Dictionary = {
	"bullet_speed_mult":float(1),
	"bullet_damage_mult":float(1),
	"bullet_lifespan_mult":float(1),
}

#Base special effects on the bullet
@export var bullet_base_effects:Dictionary = {
	"bullet_pierces":int(0),
	"bullet_explodes":bool(false),
	"bullet_bounces":int(0),
	"bullet_splits":int(0),
}

#Special effects on the bullet from upgrades
@export var bullet_upgraded_effects:Dictionary = {
	"bullet_pierces":int(0),
	"bullet_explodes":bool(false),
	"bullet_bounces":int(0),
	"bullet_splits":int(0),
}

#Bullet scene
@export var bullet_scene:PackedScene

#Gun base stats
@export var gun_base_stats:Dictionary = {
	"gun_bursts":int(1),
	"gun_burst_cooldown":float(0),
	"gun_bullets_per_shot":int(1),
	"gun_shot_cooldown":float(0.5),
}

#Additional effects to gun's stats from upgrade
@export var gun_stat_increases:Dictionary = {
	"gun_bursts_increase":int(0),
	"gun_burst_cooldown_increase":float(0),
	"gun_bullets_per_shot_increase":int(0),
	"gun_shot_cooldown_increase":float(0),
}
