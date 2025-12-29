extends Resource 

class_name BulletResource

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
