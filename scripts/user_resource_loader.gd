extends Node2D


const NO_LANG_FILES = [
	"config",
	"stages",
]


func _ready():
	print("用户资源加载器准备就绪")
	pass


func _process(delta):
	pass


func load_data(fileName: String, language: String = "zh", min: bool = false) -> String:
	var path = "data/"
	if !NO_LANG_FILES.has(fileName):
		path += language + "/"
	path += fileName
	if min:
		path += ".min"
	path += ".json"
	
	var user_path = "user://" + path
	if FileAccess.file_exists(user_path):
		print("从本地正在加载 %s" % path)
		var file = FileAccess.open(user_path, FileAccess.READ)
		var content = file.get_as_text()
		return content
	
	print("用户资源文件 %s 不存在，尝试连接 SchaleDB 下载" % user_path)
	return "{}"


func load_image_texture(path: String) -> ImageTexture:
	var user_path = "user://" + path
	if FileAccess.file_exists(user_path):
		var file = FileAccess.open(user_path, FileAccess.READ)
		var buffer = file.get_buffer(file.get_length())
		var extIndex = user_path.rfind(".")
		var ext = user_path.substr(extIndex)
		
		var image = Image.new()
		var result: int = FAILED
		match ext:
			".bmp": result = image.load_bmp_from_buffer(buffer)
			".jpg": result = image.load_jpg_from_buffer(buffer)
			".png": result = image.load_png_from_buffer(buffer)
			".tga": result = image.load_tga_from_buffer(buffer)
			".webp": result = image.load_webp_from_buffer(buffer)
			_:
				print("无法识别的格式：%s" % ext)
				return null
		
		if result == OK:
			return ImageTexture.create_from_image(image)
	
	print("用户资源文件 %s 不存在，无法加载图片" % user_path)
	return null
