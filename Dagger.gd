extends Area2D

const SPEED = 100
var velocity = Vector2()
var direction = 1 # 1 is facing right, -1 is facing left 

func set_dagger_direction(dir): 
	direction = dir  
	if dir == -1 :
		$spike.flip_h = true # this tells the dagger which way to face when coming out of knight sprite


func _physics_process(delta):
	velocity.x = SPEED * delta * direction # how fast the dagger goes, delta is if frames get skipped, direction will help dagger move left or right
	translate(velocity)  # will cause the dagger to move across the screen. 
	

func _on_VisibilityNotifier2D_screen_exited():  # will send signal when off the screen 
	queue_free() # will distory the object 
	

func _on_Dagger_body_entered(body):
	if "Enemy" in body.name:  # matchs if enemy is hit 
		body.dead(1)
	if "Zombie" in body.name:
		body.dead(1)
	queue_free()
	
