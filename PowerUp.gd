extends Area2D


func _ready(): 
	pass 

func _on_PowerUp_body_entered(body):
	if "Player" in body.name:  # We have "Player" repesent body.name, so only the user can pick up 
		body.weapon_power_up()  # body(Player) signal activated (func in Player) , should increase player's future damage
		queue_free()
