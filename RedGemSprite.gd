extends Sprite

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
		