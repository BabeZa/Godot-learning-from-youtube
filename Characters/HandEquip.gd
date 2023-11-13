@tool
extends Node2D

@onready var EquipSprite = $Item/EquipSprite
@onready var Item = $Item
@onready var CollHitbox = $Item/Hitbox/CollHitbox

@export var equipped_item : EquippableItem :
	set(next_equipped):
		equipped_item = next_equipped

func _ready():
	EquipSprite.texture = equipped_item.texture
	Item.position = equipped_item.item_position
	CollHitbox.shape = equipped_item.hitbox_shape
	CollHitbox.position = equipped_item.hitbox_position
	CollHitbox.rotation = equipped_item.hitbox_rotation

	
func _on_area_2d_body_entered(body):
	if(equipped_item.has_method("interact_with_body")):
		equipped_item.interact_with_body(body)

