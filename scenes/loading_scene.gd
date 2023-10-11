extends Node2D


@onready var background: Sprite2D = get_node("background")
@onready var description: Label = get_node("description")
@onready var progress_bar: ProgressBar = get_node("progress_bar")


enum ResourceStatus {
	None,
	Downloading,
	Completed,
}

var resources: Dictionary = {}

var completed: int:
	get:
		var counter = 0
		for res in resources:
			if resources[res] == ResourceStatus.Completed:
				counter += 1
		return counter


func _ready():
	SchaleResourceLoader.connect("download_completed", self.on_download_completed)
	start_loading()
	pass


func _process(delta):
	pass


func start_loading():
	background.texture = UserResourceLoader.load_image_texture("images/background/BG_MainOffice_Night.jpg")
	print("开始资源加载")
	loading_students()
	check_resources()


func loading_students():
	description.set_text("正在加载学生元数据")
	var content = UserResourceLoader.load_data("students", "zh")
	
	description.set_text("正在解析学生元数据")
	var datas = JSON.parse_string(content) as Array
	var amount = datas.size()
	var index = 0
	
	for data in datas:
		description.set_text("正在遍历学生元数据（%d / %d）" % [index + 1, amount])
		print("No.%d %s" % [data.Id, data.PathName])
		
		# icon / portrait
		resources["images/student/icon/%d.webp" % data.Id] = 0
		resources["images/student/portrait/%d.webp" % data.Id] = 0
		
		# background
		resources["images/background/%s.jpg" % data.CollectionBG] = 0
		
		index += 1
	pass


func check_resources():
	var amount = resources.size()
	var scan_counter = 0
	var exists_counter = 0
	for res in resources:
		description.set_text("正在检查本地资源（%d / %d）" % [exists_counter+1, amount])
		print("正在检查本地资源：%s" % res)
		var exists = UserResourceLoader.exists(res)
		if exists:
			resources[res] = ResourceStatus.Completed
			exists_counter += 1
		scan_counter += 1
	pass


func download_resources():
	var amount = resources.size()
	var counter = 0
	for res in resources:
		description.set_text("正在下载资源（%d / %d）" % [counter+1, amount])
		counter += 1
	pass


func on_download_completed(path: String, result: int):
	print("资源 %s 下载完成，状态码 %d" % [path, result])
	pass
