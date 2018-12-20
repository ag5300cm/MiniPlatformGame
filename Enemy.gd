extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const GRAVITY = 10
#const SPEED = 30 
export(int) var speed = 30  # for each world.tscn you can change the Enemies speed if so desired for each one 
const FLOOR = Vector2(0, -1) 

var velocity = Vector2()

var direction = 1  # this repsents right 

var is_dead = false 

export(int) var hp = 1 
export(Vector2) var size = Vector2(1,1) # allows you to make big or littler enemies 

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	scale = size # will change to the personalized set size per world.tscn 
	pass

func dead(damage): 
	hp = hp - damage
	if hp <= 0 :
		is_dead = true 
		velocity = Vector2(0, 0)  # prevents a dead enemy from moving 
		$CollisionShape2D.disabled = true # this makes sure a dead enemy is something you can't jump on 
		#$Skeletons.transform.rotated(90)
		$DeadSkeleton.visible = true # these two change picture 
		$Skeletons.visible = false
		$Timer.start()
		#queue_free()  # makes them disappear 
		if scale > Vector2(1,1) :  # if the enemy is larger then normal will shake the screen 
			get_parent().get_node("ScreenShake").screen_shake(1, 10, 100)  # activates the ScreenShake method. 

func _physics_process(delta): 

	if is_dead == false: 
		if direction == -1 :  # this is used for making sure the skeleton walks in the right direction, no michel jackson moon walk skills
			$Skeletons.flip_h = false 
		else :
			$Skeletons.flip_h = true 
		
		# used for moving the sprite 
		#velocity.x = SPEED * direction
		velocity.x = speed * direction
		velocity.y += GRAVITY 
		velocity = move_and_slide(velocity, FLOOR) 
	#else :
	#	$Skeletons.transform.rotated(90)
		
	if is_on_wall():  # this is to help the character change direcitons when meeting a wall 
		direction = direction * -1 
		$RayCast2D.position.x *= -1 
		
	if $RayCast2D.is_colliding() == false :  # this is to help the character change direcitons when at a leadge 
		direction = direction * - 1 
		$RayCast2D.position.x *= -1 
	
	if get_slide_count() > 0: 
		for i in range (get_slide_count()): 
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.hpLoss() # will injury the player 
				#get_slide_collision(i).collider.dead()  # will kill the player if standing still 
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	queue_free()  # makes them disappear after two second timeout
