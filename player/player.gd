extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite
export var speed = 150
var isDead = false

func _physics_process(delta):
	
	if(isDead):
		return
	
	var horizonal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if(horizonal != 0 || vertical != 0):
		animatedSprite.animation = "walking"
		animatedSprite.play("walking")
	else:
		animatedSprite.animation = "idle"
		animatedSprite.play("idle")
		
	if(horizonal > 0 ):
		animatedSprite.flip_h = false
		
	if(horizonal < 0):
		animatedSprite.flip_h = true
	
	move_and_collide(Vector2(horizonal * speed,vertical * speed ) *delta)

 
func death():
	if(!isDead):
		isDead = true
		animatedSprite.animation = "death"
		animatedSprite.play("death")
		yield(animatedSprite,"animation_finished")
		yield(get_tree().create_timer(0.5),"timeout")
		# Scene to game over 
		
