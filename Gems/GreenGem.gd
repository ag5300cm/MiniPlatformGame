extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _physics_process(delta): 
	var bodies = get_overlapping_bodies() # sees if anything is touchin it 
	print(bodies) 
	for body in bodies :
		if body.name == "Player" :
			pass # 
			#get_tree().change_scene("World2.tscn") 
			
