extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
           #  \/ Vector2 can hold both an x and a y value ; other way to write it var motionx = 0 ; var motiony = 0 
var motion = Vector2() # to access we can use motion.x or motion.y 
#  \/ constants should be All Capitals for proper edicate 
const UP = Vector2(0, -1 ) # this creates the direction up 
const GRAVITY = 20 
const MAX_SPEED = 200
const JUMP_HEIGHT = -550
const ACCELERATION = 50 # v3

func _physics_process(delta): 
	motion.y += GRAVITY
	var friction = false 
	#motion.y += 10 # adding gravity to our frame 

	if Input.is_action_pressed("ui_right") :
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED) # 'min' function will set our motion to the smaller of the two, like an if statment below 
		#motion.x += ACCELERATION
		#motion.x = min(motion.x , MAX_SPEED)
		#if motion.x > MAX_SPEED :  # or can use the "min" above 
		#	motion.x = MAX_SPEED
		#motion.x = SPEED # will move us 200 pixels right 
		#motion.x = 100 # will move us 100 pixels right 
		# the really easy way to get access to the sprite is to use a dollar sign in front of it so access it's own sprite
		$Sprite.flip_h = false   # at this point the animation should turn right 
		#get_node("Sprite").flip_h = false # another way to write above 
		#$Sprite.animation = "run" 
		$Sprite.play("run") 
		
	elif Input.is_action_pressed('ui_left') : # for moving left 
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED ) 
		#motion.x -= ACCELERATION # zipity zoo da fast
		#motion.x = -SPEED
		#motion.x = -100
		$Sprite.flip_h = true # at this point the animation should turn left 
		$Sprite.play("run") 
	else : 
		$Sprite.play("idle")  # plays idle animation if standing still 
		friction = true 
		motion.x = lerp(motion.x, 0, 0.2) # lerp slows you down more human like no direct stop. 
						# /\ the three things its need is your current speed, what you are slowing down to, and percentage of slowdown
		#motion.x = 0
		#$Sprite.animation = "Idle"
		
		
		
	if is_on_floor() :
		#print("On floor.") 
		if Input.is_action_just_pressed("ui_up") :
			motion.y = JUMP_HEIGHT
			#motion.y = -400
		if friction == true :
			motion.x = lerp(motion.x, 0 , 0.2 )
	else : 
		if motion.y < 0 : # our y motion is negative, so we are going up 
			$Sprite.play("jump")  # if in the air will play jump animaiton 
		else :
			$Sprite.play('Fall') 
		if friction == true :
			motion.x = lerp(motion.x, 0 , 0.05 )
		

	motion = move_and_slide(motion, UP) # this will now stop the "gravity" (motion,y += 10) from continously going; AKA reset to 0 
	#print(motion)  # used for trouble shooting  
	#move_and_slide(motion, UP)
	#move_and_slide(motion) # was used for just left and right 
	
	pass 
# Very Simple Camera 
# for Player : Camera2d make sure you click on the  "Current" to On 
# also turn off "Drag Margin H Enabled" and "Drag Margin V Enabled" 
# 
# in ParallaxLayer do mirroring ( which will repeat the image) 
# by how large you screen is (ex: 640 , 640) 
# the ParallaxLayer's scale is how fast this background will follow the player 
# curretly set to 0.1 and 0.1 

# project settings -> Rendering -> Quality -> "Use pixel snap" set to ON
