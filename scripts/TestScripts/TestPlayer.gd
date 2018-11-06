extends KinematicBody2D

export var speed : int = 200
export var rotation_speed : float = 3

var velocity : Vector2 = Vector2()
var rotation_dir : float = 0

func get_input():
	rotation_dir = 0
	var x = 0
	var y = 0

	if Input.is_action_pressed('rotate_counter_clockwise'):
		rotation_dir -= 1
	if Input.is_action_pressed('rotate_clockwise'):
		rotation_dir += 1
	
	if Input.is_action_pressed('right'):
		x += 1
	if Input.is_action_pressed('left'):
		x -= 1
	
	
	if Input.is_action_pressed('down'):
		y += 1
	if Input.is_action_pressed('up'):
		y -= 1
        
	velocity = Vector2(x, y).rotated(rotation) * speed

func _physics_process(delta):
    get_input()
    rotation += rotation_dir * rotation_speed * delta
    move_and_slide(velocity)