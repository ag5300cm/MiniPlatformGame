extends KinematicBody2D


# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const GRAVITY = 10
#const SPEED = 30 
export(int) var speed = 30 
const FLOOR = Vector2(0, -1) 

var velocity = Vector2()

var direction = 1  # this repsents right 

var is_dead = false 

export(int) var hp = 2 # all zombies start with two hitpoints, can change it to more or less in each world.tscn on each character  

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func dead(damage): 
	hp = hp - damage
	if hp <= 0 :
		is_dead = true 
		velocity = Vector2(0, 0)  # prevents a dead enemy from moving 
		$CollisionShape2D.disabled = true # this makes sure a dead enemy is something you can't jump on 
		$DeadZombie.visible = true  # changes pics to make it look more dead 
		$ZombiePics.visible = false 
		$Timer.start()
		#queue_free()  # makes them disappear 

func _physics_process(delta): 
	
	if is_dead == false: 
		if direction == -1 :  # this is used for making sure the skeleton walks in the right direction, no michel jackson moon walk skills
			$ZombiePics.flip_h = false 
		else :
			$ZombiePics.flip_h = true 
		
		# used for moving the sprite 
		#velocity.x = SPEED * direction
		velocity.x = speed * direction
		velocity.y += GRAVITY 
		velocity = move_and_slide(velocity, FLOOR) 
		
	if is_on_wall():  # this is to help the character change direcitons when meeting a wall 
		direction = direction * -1 
		$RayCast2D.position.x *= -1 
	
	if $RayCast2D.is_colliding() == false :  # this is to help the character change direcitons when at a leadge 
		direction = direction * - 1 
		$RayCast2D.position.x *= -1 
	
	if get_slide_count() > 0: 
		for i in range (get_slide_count()): 
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.hpLoss() 
				#get_slide_collision(i).collider.dead()  # will kill the player if standing still 

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	queue_free() # makes is disappear
