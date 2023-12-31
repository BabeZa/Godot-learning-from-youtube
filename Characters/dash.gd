extends Node2D

const dash_delay = 0.4
@onready var duration_timer = $DurationTimer
@onready var ghost_timer = $GhostTimer
var ghost_scene = preload("res://Characters/dash_ghost.tscn")
var can_dash = true
var sprite

func start_dash(sprite, duration):
	self.sprite = sprite
	sprite.material.set_shader_parameter("mix_weight", 0.7)
	sprite.material.set_shader_parameter("whiten", true)
	
	duration_timer.wait_time = duration
	duration_timer.start()
	ghost_timer.start()
	instance_ghost()
	
func instance_ghost():
	var ghost : Sprite2D = ghost_scene.instantiate()
	get_parent().get_parent().add_child(ghost)
	
	ghost.global_position = global_position
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame   = sprite.frame
	ghost.flip_h  = sprite.flip_h
	
func is_dashing():
	return !duration_timer.is_stopped()

func end_dash():
	ghost_timer.stop()
	sprite.material.set_shader_parameter("whiten", false)
	
	can_dash = false
	await get_tree().create_timer(dash_delay).timeout
	can_dash = true


func _on_duration_timer_timeout():
	end_dash()


func _on_ghost_timer_timeout():
	instance_ghost()
