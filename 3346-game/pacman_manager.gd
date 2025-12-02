extends CharacterBody2D

class_name Player

var movement_direction = Vector2.ZERO


@export var speed = 700
@export var start_position: Node2D


@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	reset_player()

func reset_player():
	set_physics_process(true)
	movement_direction = Vector2.ZERO
	
func _physics_process(delta):
	velocity = movement_direction * speed * delta
	move_and_slide()
	

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("left"):
		movement_direction = Vector2.LEFT
	elif  Input.is_action_pressed("right"):
		movement_direction = Vector2.RIGHT
	elif Input.is_action_pressed("down"):
		movement_direction = Vector2.DOWN
	elif Input.is_action_pressed("up"):
		movement_direction = Vector2.UP
