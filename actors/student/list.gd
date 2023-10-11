extends Node2D


const IconActor = preload("res://actors/student/icon.tscn")
const ICONS_PER_ROW = 6

const ICON_WIDTH = 150
const ICON_HEIGHT = 170


func _enter_tree():
	pass


func _ready():
	var metadata_list = MetadataLoader.load_from_schale()
	var index = 0
	for metadata in metadata_list:
		var icon = IconActor.instantiate()
		icon.name = "student_%d" % metadata.id
		print("正在创建图标 %s" % icon.name)
		
		icon.id = metadata.id
		
		var x: int = index % ICONS_PER_ROW
		var y: int = index / ICONS_PER_ROW
		icon.position.x = x * ICON_WIDTH
		icon.position.y = y * ICON_HEIGHT
		
		add_child(icon)
		index += 1
	pass


func _process(delta):
	pass
