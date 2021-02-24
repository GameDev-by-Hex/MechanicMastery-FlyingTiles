extends Node2D

onready var flying_tiles_group := $flying_tiles
onready var player := $player
onready var flying_tile = $flying_tiles/flying_tile
onready var tile_timer = $flying_tiles/tile_timer

export var room_triggered : bool = false
export var time_between_tiles = 0.8
export var max_number_tiles_raised = 6

var flying_tiles_children = null
var current_tiles_raised = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	flying_tiles_children = flying_tiles_group.get_children()
	randomize()
	

func _physics_process(delta):
	
	if(room_triggered && current_tiles_raised < max_number_tiles_raised && tile_timer.is_stopped()):		
		var randomTile = randi()%flying_tiles_group.get_child_count() - 1 
		var flying_tile = flying_tiles_children[randomTile]		
		launch_tile(flying_tile)
		
		
		# launch tile at the player (Handled in the flying tile code)
		
func launch_tile(var flying_tile_child ):
	
	if(flying_tile_child && flying_tile_child.has_method("raise_and_attack")):	
		current_tiles_raised += 1
		flying_tile_child.raise_and_attack() # raise the tile 
		flying_tile_child.player_position = player.get("global_position")
		tile_timer.start(time_between_tiles)


func _on_TileTrigger_body_entered(body):
	if(!room_triggered):
		room_triggered = true
