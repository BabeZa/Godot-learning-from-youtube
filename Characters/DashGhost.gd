extends Sprite2D



func _ready():	
	
	var tween:Tween = get_tree().create_tween().bind_node(self) #Creates a Tween, as far as I know Tween as a node has been removed

	#Sets transition and ease for all following tweens
	tween.set_trans(Tween.TRANS_QUART) 
	tween.set_ease(Tween.EASE_OUT)


	#Tween to execute, 
	tween.tween_property(self, "modulate:a", 0, 1)
	#REF https://ask.godotengine.org/141045/godot-texture-modulated-tweener-doesnt-passed-attached-shader

	# Extra: In my case I added this callback to a function named "finished", I leave it here in case you need to call a function when the upper tweens finish.
	tween.tween_callback(finished)
	
func finished():
	queue_free()
	pass
