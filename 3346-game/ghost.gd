extends CharacterBody2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var pacman := $"../Pacman"
@export var type : GhostType

var scatter
@onready var scatterGoal = $"scatterPos"



enum GhostType {Blinky, Pinky, Inky, Clyde}


func _physics_process(delta: float) -> void:
	if scatter:
		agent.target_position = scatterGoal.global_position
		
		if global_position.distance_to(scatterGoal.global_position) < 20:
			scatter = false
	else:
	
		if type == GhostType.Blinky:
			# Continuously update target
			agent.target_position = pacman.global_position
		
		if type == GhostType.Pinky:
			agent.target_position = pacman.prediction_spot.global_position
		
		if type == GhostType.Inky:
			agent.target_position = pacman.global_position + (pacman.global_position - $"../Blinky".global_position)
		
		if type == GhostType.Clyde:
			if pacman.global_position.distance_to(global_position) > 50 and !scatter:
				agent.target_position = pacman.global_position
			elif !scatter:
				scatter = true
		
	
	

	# Get next path point
	var next_point = agent.get_next_path_position()

	# Move toward it
	var direction = (next_point - global_position).normalized()
	velocity = direction * 60  # ghost speed

	move_and_slide()
