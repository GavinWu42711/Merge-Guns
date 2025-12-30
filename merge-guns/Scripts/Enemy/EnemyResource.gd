extends Resource

class_name EnemyResource

enum base_stats_enum{
	HEALTH,
	DAMAGE,
	SPEED
	}
	
enum stat_mults_enum{
	HEALTH_MULT,
	DAMAGE_MULT,
	SPEED_MULT,
	SIZE_MULT
}

#Base special effects and special effects that can be gained are the same
enum special_effects{
	REVIVE,
	EXPLODE
}

#Base stats of enemy at the start of the game
@export var base_stats:Dictionary = {
	base_stats_enum.HEALTH:float(1),
	base_stats_enum.DAMAGE:float(0),
	base_stats_enum.SPEED:float(0)
}

#Increase on the stats of enemy due to gameplay
@export var stat_mults:Dictionary = {
	stat_mults_enum.HEALTH_MULT:float(1),
	stat_mults_enum.DAMAGE_MULT:float(1),
	stat_mults_enum.SPEED_MULT:float(1),
	stat_mults_enum.SIZE_MULT:float(1)
}

#Base special effects of the enemy; typically happens on death
@export var base_special_effects:Dictionary = {
	special_effects.REVIVE:int(0),
	special_effects.EXPLODE:bool(false),
}

#Special effects not inherit to the enemy but gotten due to player actions/gameplay
@export var special_effects_upgrade:Dictionary = {
	special_effects.REVIVE:int(0),
	special_effects.EXPLODE:bool(false),
}
