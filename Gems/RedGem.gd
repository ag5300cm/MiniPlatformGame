extends Area2D


func _on_RedGem_body_entered(body):
	if "Player" in body.name:  # We have "Player" repesent body.name, so only the user can pick up 
		body.red_gem_aquired()  # body(Player) signal activated (func in Player) , should increase player's future damage
		queue_free()