extends Area2D


onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var collision = $Collision

func _ready():
	sprite.visible = false
	collision.disabled = true


func swing(value : bool = true):
	if !animation_player.is_playing():
		if value == true:
			animation_player.play("test_swing_right")
		else:
			animation_player.play("test_swing_left")
