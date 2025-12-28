extends Resource 

class_name BulletResource

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
