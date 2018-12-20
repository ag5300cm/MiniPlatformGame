extends KinematicBody2D

# Z index set to one, should make sure player is always in front, Higher Z index the more on top it's drawn 

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const PINKGEMS = preload("res://Gems/PinkGem.tscn")
var PINKY = 0
var BLUEGEMS = 0

var isAttacking = false 
var isjumpAttacking = false 
var is_dead = false 
           #  \/ Vector2 can hold both an x and a y value ; other way to write it var motionx = 0 ; var motiony = 0 
var motion = Vector2() # to access we can use motion.x or motion.y 
#  \/ constants should be All Capitals for proper edicate 
const UP = Vector2(0, -1 ) # this creates the direction up 
const GRAVITY = 20 
const MAX_SPEED = 200
const JUMP_HEIGHT = -550
const ACCELERATION = 50 # v3

const DAGGER = preload("res://Dagger.tscn") # preloads dagger for player to use 
const CUTLASS = preload("res://Cutlass.tscn")
var daggerLeftRigth = 1

var dagger_power = 1

export(int) var hp = 30 # player hitpoints edit here or in each world 


func _physics_process(delta): 
	motion.y += GRAVITY
	var friction = false 
	#motion.y += 10 # adding gravity to our frame 
	
	if is_dead == false :
		
		if Input.is_action_pressed("ui_right") :
			if isAttacking == false && isjumpAttacking == false || is_on_floor() == false :
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
				daggerLeftRigth = 1
		elif Input.is_action_pressed('ui_left') : # for moving left 
			if isAttacking == false && isjumpAttacking == false  || is_on_floor() == false :
				motion.x = max(motion.x - ACCELERATION, -MAX_SPEED ) 
				#motion.x -= ACCELERATION # zipity zoo da fast
				#motion.x = -SPEED
				#motion.x = -100
				$Sprite.flip_h = true # at this point the animation should turn left 
				$Sprite.play("run") 
				daggerLeftRigth = 0
		else : 
			if isAttacking == false && isjumpAttacking == false :
				$Sprite.play("idle")  # plays idle animation if standing still 
				friction = true 
				motion.x = lerp(motion.x, 0, 0.2) # lerp slows you down more human like no direct stop. 
								# /\ the three things its need is your current speed, what you are slowing down to, and percentage of slowdown
				#motion.x = 0
				#$Sprite.animation = "Idle"
		# for when the player wants to attack 
		if Input.is_action_just_pressed("ui_accept") && isAttacking == false && isjumpAttacking == false :
			if dagger_power == 1: 
				var dagger = DAGGER.instance()  #variable for our preloaded sceen.
				get_parent().add_child(dagger) # get_parent is the World the knight sprite is currently in. 
				if daggerLeftRigth == 1: 
					dagger.set_dagger_direction(1)   #how to summon a function from the dagger.tscn this sets dagger direction 
					dagger.position = $Position2DRight.global_position  # launch of dagger 
				else: 
					dagger.set_dagger_direction(-1)  #how to summon a function from the dagger.tscn this sets dagger direction 
					dagger.position = $Position2DLeft.global_position
			elif dagger_power == 2 :
				var cutlass = CUTLASS.instance() 
				get_parent().add_child(cutlass)
				if daggerLeftRigth == 1:
					cutlass.set_dagger_direction(1)
					cutlass.position = $Position2DRight.global_position
				else:
					cutlass.set_dagger_direction(-1) 
					cutlass.position = $Position2DLeft.global_position
			#dagger.position = $Position2D.global_position # will cause dagger to come out at position2d not where knight sprite is. 
			isAttacking = true 
			$Sprite.play("attack")
		#if Input.is_action_just_pressed("ui_up") && Input.is_action_just_pressed("ui_accept")  && isAttacking == false && isjumpAttacking == false :
		#	isjumpAttacking = true 
		#	$Sprite.play("jumpAttack")  
			
		if is_on_floor() :
			#print("On floor.") 
			if Input.is_action_just_pressed("ui_up") :
				if isAttacking == false && isjumpAttacking == false:
					motion.y = JUMP_HEIGHT
				#motion.y = -400
			if friction == true :
				motion.x = lerp(motion.x, 0 , 0.2 )
		else : 
			if isAttacking == false && isjumpAttacking == false :
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
		if get_slide_count() > 0:  # after move_and_slide function gets all collisions that could have happened 
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:  # Enemy aka skeleton 
					hp = hp - 1 
					if hp <= 0 :
						dead()  #plays function dead(), which kills player
				if "Zombie" in get_slide_collision(i).collider.name:
					hp = hp - 1 
					if hp <= 0 :
						dead()  #plays function dead(), which kills player
		
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

func on_Player_body_entered(body): # to hopefully make the gems disabppear
	#body.queue_free() 
	self.queue_free()
	pass  

func hpLoss() :
	hp = hp - 1 
	if hp <= 0 :
		dead() 
	else:
		$TimerInvincable.start()

func dead():
	is_dead = true 
	$Sprite.play('dead') 
	$CollisionShape2D.disabled = true 
	$Timer.start() 

func _on_Sprite_animation_finished():
	isAttacking = false 
	isjumpAttacking = false 

func _on_Timer_timeout():
	get_tree().change_scene("StartMenu.tscn")  # back to the beginning 

func weapon_power_up():  # this works with the cutlass and will increase players attack damage 
	dagger_power = 2
	
func health_increase():  # this works with the pink gem should currently increase health 
	hp = hp + 5 
	
func black_gem_aquired():
	pass
	
func blue_gem_aquired():
	pass
	
func yellow_gem_aquired():
	pass
	
func red_gem_aquired():
	pass
	
func green_gem_aquired():
	pass

func _on_TimerInvincable_timeout():  # if injured this will take action, 
	motion.y = -600  # you jump 600 pixels out to safety 
	
	#$CollisionShape2D.disabled = true 
	
