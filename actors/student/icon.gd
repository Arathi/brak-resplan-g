@tool
extends Node2D


const Student = preload("res://domains/student.gd")
const Metadata = preload("res://domains/metadata/student.gd")


@export var id: int = 10000:
	set(value):
		id = value
		update()


@onready var avatar_sprite: Sprite2D = get_node("clip/avatar")
@onready var name_label: Label = get_node("name")


var student: Student:
	get:
		return null

var metadata: Metadata:
	get:
		return MetadataLoader.get_student_by_id(id)


# Called when the node enters the scene tree for the first time.
func _ready():
	update()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update():
	if avatar_sprite == null:
		return
	
	var avatar_texture = UserResourceLoader.load_image_texture("images/student/icon/%d.webp" % id)
	avatar_sprite.set_texture(avatar_texture)
	
	name_label.set_text(metadata.name)
	
	pass
