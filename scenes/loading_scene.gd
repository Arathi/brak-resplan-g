extends Node2D


@onready var background: Sprite2D = get_node("background")
@onready var description: Label = get_node("description")
@onready var progress_bar: ProgressBar = get_node("progress_bar")


func _ready():
	SchaleResourceLoader.connect("download_completed", self.on_download_completed)
	start_loading()
	pass


func _process(delta):
	pass


func start_loading():
	background.texture = UserResourceLoader.load_image_texture("images/background/BG_MainOffice_Night.jpg")
	
	print("开始资源加载")
	description.set_text("正在加载学生元数据")
	var content = UserResourceLoader.load_data("students", "zh")
	
	description.set_text("正在解析学生元数据")
	var datas = JSON.parse_string(content) as Array
	var amount = datas.size()
	var index = 0
	
	for data in datas:
		description.set_text("正在遍历学生元数据（%d / %d）" % [index + 1, amount])
		print("No.%d %s" % [data.Id, data.PathName])
		index += 1
	
	pass


func on_download_completed(path: String, result: int):
	print("资源 %s 下载完成，状态码 %d" % [path, result])
	pass
