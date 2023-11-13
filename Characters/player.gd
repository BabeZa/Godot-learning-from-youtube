extends CharacterBody2D

var health = 100

@export var move_speed = 80
@export var dash_speed = 200
const dash_duration = 0.2


var mouse_pos = Vector2.ZERO
var player_dir = "Right"
var moveDirection = Vector2.ZERO

@onready var animation = $AnimationPlayer
@onready var sprite = $SpriteBody
@onready var Hand = $Hand
@onready var Dash = $Dash
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var hand_animation : AnimationPlayer = $Hand/HandAnimationPlayer

func _ready():
	#animation.play("Idle")
	animation_tree.active = true
	#hand_animation.play("idle")
	
	

func _physics_process (delta):
	player_movement (delta)
	handle_mouse_input()
	update_animation_paramesters()

	
	
func player_movement (_delta):
	moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	if Input.is_action_just_pressed("ui_select") && Dash.can_dash && !Dash.is_dashing():
		Dash.start_dash(sprite, dash_duration)
		
	var speed = dash_speed if Dash.is_dashing() else move_speed
	
	velocity = moveDirection * speed

	move_and_slide()

func handle_mouse_input():
	mouse_pos = get_global_mouse_position()
	Hand.look_at(mouse_pos)

	if mouse_pos.x < global_position.x :
		player_dir = "left"
		Hand.rotation_degrees = wrapf(Hand.rotation_degrees -180, -90, 90)
	elif mouse_pos.x >= global_position.x :
		player_dir = "Right"
	
	#weapon.damage_source_pos = global_position



func update_animation_paramesters():
	if velocity == Vector2.ZERO :
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		
	if( Input.is_action_just_pressed("use") ):
		hand_animation.play("swing")
	
		
	var moveDirection_anim = moveDirection
	if player_dir == "left" :
		sprite.flip_h = true
		Hand.scale.x = -1
		moveDirection_anim.x = moveDirection.x * -1

	elif player_dir == "Right" :
		sprite.flip_h = false
		Hand.scale.x = 1
		moveDirection_anim.x = moveDirection.x 
		
	animation_tree["parameters/Walk/blend_position"] = moveDirection_anim




