extends Sprite


# TODO make this for all the gems so don't need for each one with a seperate thing. 

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var timer 

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	timer = Timer.new()
	timer.connect("timeout", self, "tick")
	add_child(timer)
	timer.wait_time = 0.2
	timer.start()
	
func tick():
	if self.frame < 7:  # because we have 8 images we neeed to reset after seven 
		self.frame = self.frame + 1
	else:
		self.frame = 0
		

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
