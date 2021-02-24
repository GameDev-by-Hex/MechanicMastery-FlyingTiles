extends KinematicBody2D

onready var tile = $tile


#  Move the tile's  position by a specific distance (up) (-y direction)

export var tile_lift_distance := 25
export var rotation_speed := 0.20
export var tile_lift_speed := 20
export var tile_translate_speed := 150

var tile_height_raised = null
export var shouldRaise : bool = false
var player_position = null
var trajectory = null
# Called when the node enters the scene tree for the first time.
func _ready():
	tile_height_raised = tile.position.y - tile_lift_distance
	
	
func _physics_process(delta):
	
	if(shouldRaise):
		tile.rotate(rotation_speed)
		if(tile.position.y >= tile_height_raised): # Raise the position 
			tile.position.y -= (tile_lift_speed * delta)
		
		else: # Once Raised launch the tile at the player
			if(player_position && !trajectory):
				# Player positon - tilePosition, normalize = trajectory  
				trajectory = (player_position - global_position).normalized()				
				
			# player's position 
			# translate the tiles position 
			if(trajectory):
				translate(trajectory*tile_translate_speed*delta)

func raise_and_attack():
	shouldRaise = true

 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_flying_tile_detector_body_entered(body):
	print("body:",body)
	if(shouldRaise):
		if(body.has_method("death")):
			body.death()
		
		tile_translate_speed = 0
		tile.animation = "destruction"
		tile.play("destruction")
	
		yield(tile,"animation_finished")
		queue_free()
		
	
