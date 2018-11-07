extends KinematicBody2D


export (float) var mass : float = 1

export (float) var force : float = 200
export (float) var friction : float = 1

export (float) var rot_force : float = deg2rad(90)
export (float) var rot_friction : float = 0.25

onready var sword = $TestSword

var velocity : Vector2 = Vector2()
var rot_velocity : float = 0


func get_rotation_input():
	var rotationInput = 0
	
	if Input.is_action_pressed("rotate_counter_clockwise"):
		rotationInput -= 1
	if Input.is_action_pressed("rotate_clockwise"):
		rotationInput += 1
	
	return rotationInput


func get_movement_input():
	var movementInput : Vector2 = Vector2(0, 0)
	
	if Input.is_action_pressed("forward"):
		movementInput.y -= 1
	if Input.is_action_pressed("backward"):
		movementInput.y += 1
	
	return movementInput


func _process(delta):
	if Input.is_action_just_pressed("swing_sword"):
		var swing_right : bool = rot_velocity > 0
		sword.swing(swing_right)


func _physics_process(delta):
	var newVelocity : Vector2 = velocity
	var newRotVelocity : float = 0

	# apply friction
	if velocity.length() > 0:
		var frictionAmount = friction * delta
		var deceleration = velocity * frictionAmount
		
		newVelocity = velocity - deceleration
		
		if newVelocity.length() < 0.05:
			newVelocity = Vector2(0, 0)
	
	# apply acceleration
	var movementInput : Vector2 = get_movement_input()
	
	if movementInput.length() > 0:
		if movementInput.length() > 1:
			movementInput = movementInput.normalized()
		
		var forceAmount = movementInput * force
		var acceleration = forceAmount / mass
		var addedVelocity = acceleration * delta
		
		newVelocity += addedVelocity.rotated(rotation)
	
	# apply rotational friction
	if abs(rot_velocity) > 0:
		var frictionAmount = rot_friction * delta
		var deceleration = rot_velocity * frictionAmount
		
		newRotVelocity = rot_velocity - deceleration
		
		if abs(newRotVelocity) < 0.01:
			newRotVelocity = 0
	
	# apply rotational acceleration
	var rotMovementInput = get_rotation_input()
	
	if rotMovementInput != 0:
		var forceAmount = rotMovementInput * rot_force
		var acceleration = forceAmount / mass
		var addedVelocity = acceleration * delta
		
		newRotVelocity += addedVelocity
	
	rot_velocity = newRotVelocity
	
	rotation +=  rot_velocity * delta
	velocity = move_and_slide(newVelocity)
	
	pass