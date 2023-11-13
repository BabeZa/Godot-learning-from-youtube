extends EquippableItem

class_name HarvestingTool

@export var effected_types : Array[ResourceNodeType]
@export var min_damage : int = 1
@export var max_damage : int = 1


func interact_with_body(body):
	if (body is ResourceNode):
		for type in effected_types:
			if (body.node_types.has(type)):
				print("Match found at type " + type.display_name + " on " + body.name)
