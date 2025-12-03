extends CharacterBody2D

class_name Player

var movement_direction = Vector2.ZERO


<<<<<<< Updated upstream
@export var speed = 300
=======

@export var speed = 700
>>>>>>> Stashed changes
@export var start_position: Node2D
@onready var prediction_spot: Node2D = $RayCast2D/predictionSpot
@onready var ray_cast_2d: RayCast2D = $RayCast2D


@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	reset_player()

func reset_player():
	set_physics_process(true)
	movement_direction = Vector2.ZERO
	
func _physics_process(delta):
	if movement_direction != Vector2.ZERO:
		rotation = movement_direction.angle()
		ray_cast_2d.target_position = movement_direction * 70

	ray_cast_2d.rotation = (movement_direction * Vector2(0, -1)).angle() # Invert Y axis vector

	velocity = movement_direction * speed * delta
	move_and_slide()
	
	if ray_cast_2d.is_colliding():
		prediction_spot.global_position = ray_cast_2d.get_collision_point()
	else:
		prediction_spot.global_position = ray_cast_2d.to_global(ray_cast_2d.target_position)


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("left"):
		movement_direction = Vector2.LEFT
	elif  Input.is_action_pressed("right"):
		movement_direction = Vector2.RIGHT
	elif Input.is_action_pressed("down"):
		movement_direction = Vector2.DOWN
	elif Input.is_action_pressed("up"):
		movement_direction = Vector2.UP
