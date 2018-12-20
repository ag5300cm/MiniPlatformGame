extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _physics_process(delta): 
#	var bodies = get_overlapping_bodies() # sees if anything is touchin it 
#	print(bodies) 
#	for body in bodies :
#		if body.name == "Player" :
#			#emit_signal(KinematicBody2D)
#			self.queue_free()  # this will delete the gem once the player touches it. 
#			pass # 
			#get_tree().change_scene("World2.tscn") 

func _on_PinkGem_body_entered(body):
	if "Player" in body.name:  # We have "Player" repesent body.name, so only the user can pick up 
		body.health_increase()  # body(Player) signal activated (func in Player) , should increase player's future damage
		queue_free()
