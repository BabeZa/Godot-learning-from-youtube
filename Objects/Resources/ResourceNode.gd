extends StaticBody2D

class_name ResourceNode

@export var node_types : Array[ResourceNodeType]
@export var starting_resources : int = 1

var current_resource : int

func _ready():
	current_resource = starting_resources
	
func harvest(resource_node):
	pass

