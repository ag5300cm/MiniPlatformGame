extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _on_YellowGem_body_entered(body):
	if "Player" in body.name:  # We have "Player" repesent body.name, so only the user can pick up 
		body.yellow_gem_aquired()  # body(Player) signal activated (func in Player) , should increase player's future damage
		queue_free()