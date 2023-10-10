extends Node


const baseURL: String = "https://schale.gg/"


signal download_completed(path: String, result: int)


const NO_LANG_FILES = [
	"config",
	"stages",
]


func load_data(fileName: String, language: String = "zh", min: bool = false) -> String:
	# 拼接URI
	var uri = "data/"
	if !NO_LANG_FILES.has(fileName):
		uri += language + "/"
	uri += fileName
	if min:
		uri += ".min"
	uri += ".json"
	
	return ""


func load_image(fileName: String) -> ImageTexture:
	var uri = "images/"
	
	return null


func download(uri: String, path: String) -> bool:
	var url = baseURL + uri
	
	var req = HTTPRequest.new()
	add_child(req)
	
	req.download_file = path
	var resp = await req.request_completed
	var result = resp[0]
	download_completed.emit(path, result)
	
	return result == HTTPRequest.RESULT_SUCCESS


func _ready():
	print("沙勒资源加载器准备就绪")
	pass


func _process(delta):
	pass
