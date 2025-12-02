extends CharacterBody2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var pacman := $"../Pacman"

func _ready() -> void:
	agent.target_position = pacman.global_position

func _physics_process(delta: float) -> void:
	# Continuously update target
	agent.target_position = pacman.global_position

	# Get next path point
	var next_point = agent.get_next_path_position()

	# Move toward it
	var direction = (next_point - global_position).normalized()
	velocity = direction * 60  # ghost speed

	move_and_slide()
