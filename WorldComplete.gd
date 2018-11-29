# WorldComplete.gd
extends Area2D

# export, does : creates a variable that we can edit in the nodes properties instead of inside of the code 
export(String, FILE, "*.tscn") var world_scene

func _physics_process(delta): 
	var bodies = get_overlapping_bodies() # sees if anything is touchin it 
	print(bodies) 
	for body in bodies :
		if body.name == "Player" :
			get_tree().change_scene(world_scene) # In world.tscn we click on WorldComplete, find world_scene variable in inspector 
												# click on the file next to it and set the world we want to go to. 
			#get_tree().change_scene("World2.tscn") 
			
# right click on it saved world branch as scene, this allows you to use it in other things 
# Use the link button next to plus button to attach it to other worlds 