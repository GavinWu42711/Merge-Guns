extends Resource

class_name GunResource

#Starting stats of the bullet for a gun
@export var bullet_base_stats:Dictionary = {
	"bullet_speed":float(),
  	"bullet_damage":float(),
	"bullet_lifespan":float(),
}

#Multipliers on the bullet for a gun from upgrades
@export var bullet_stat_mults:Dictionary = {
	"bullet_speed_mult":float(),
	"bullet_damage_mult":float(),
	"bullet_lifespan_mult":float(),
}

#Special effects on the bullet
@export var bullet_effects:Dictionary = {
	"bullet_pierces":int(),
	"bullet_explodes":bool(),
	"bullet_bounces":int(),
	"bullet_splits":int(),
}

#Bullet scene
@export var bullet_scene:PackedScene

#Gun base stats
@export var gun_base_stats:Dictionary = {
	"gun_bursts":int(),
	"gun_burst_cooldown":float(),
	"gun_bullets_per_shot":int(),
	"gun_shot_cooldown":float(),
}

#Additional effects to gun's stats from upgrade
@export var gun_stat_increases:Dictionary = {
	"gun_bursts_increase":int(),
	"gun_burst_cooldown_increase":float(),
	"gun_bullets_per_shot_increase":int(),
	"gun_shot_cooldown_increase":float(),
}
