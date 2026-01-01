extends Node

"""
To-Do: Implement upgrades for enemies to allow for scaling throughout the game
"""

#Dictionary of all upgrades  that have taken place on the gun and its bullets
var gun_upgrades:Dictionary = {
	"all":GunResource.new()
}

#Emit signal to have all guns fetch respective upgrades
signal get_upgrade(gun_type:String)

#Emit signal to track a new upgrade
signal new_upgrade(gun_type:String,upgrades:GunResource)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_upgrade.connect(upgrade_gun)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#Adds on the upgrades to the existing list of upgrades
func upgrade_gun(gun_type:String, upgrades:GunResource) -> void:
	if gun_upgrades.get(gun_type) != null:
		for stat_mult_upgrade in upgrades.bullet_stat_mults.keys():
			# Need the minus one to get the proper total mult increase. Mults do not work exponentially and are additive
			gun_upgrades[gun_type].bullet_stat_mults[stat_mult_upgrade] += upgrades.bullet_stat_mults[stat_mult_upgrade] - 1 
		
		for effect_upgrade in upgrades.bullet_upgraded_effects.keys():
			if upgrades.bullet_upgraded_effects[effect_upgrade] is bool:
				gun_upgrades[gun_type].bullet_upgraded_effects[effect_upgrade] = (upgrades.bullet_upgraded_effects[effect_upgrade] or gun_upgrades[gun_type].bullet_upgraded_effects[effect_upgrade])
			else:
				gun_upgrades[gun_type].bullet_upgraded_effects[effect_upgrade] += upgrades.bullet_upgraded_effects[effect_upgrade]
		
		for stat_increase in upgrades.gun_stat_increases.keys():
			gun_upgrades[gun_type].gun_stat_increases[stat_increase] += upgrades.gun_stat_increases[stat_increase]
	else:
		#If the gun type isn't populated in the dictionary yet
		gun_upgrades[gun_type] = upgrades.duplicate(true)
		
	#Applies upgrades to all guns affected
	get_upgrade.emit(gun_type)
