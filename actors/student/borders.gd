@tool
extends Node2D

# 头像（正方形）边长
const avatar_size = 120

# 头像缺口大小（直角边长）
const avatar_lt_gap = 5

# 边框线宽
const border_line_width = 1
const border_diagonal_width = sqrt(2)

# 内边距（边框到图片边缘的留白）
@export var padding: float = 4

# 左下、右上圆角半径
@export var radius_lbrt: float = 8

# 边框颜色
@export var border_color: Color = Color("#D9DADC")

# 背景颜色
@export var background_color: Color = Color("#ffffff"):
	set(value):
		background_color = value
		queue_redraw()


# 图片外边距
var avatar_margin: float:
	get:
		return border_line_width + padding

# 边框边长
var border_size: float:
	get:
		return avatar_size + avatar_margin * 2


# Called when the node enters the scene tree for the first time.
func _ready():
	queue_redraw()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _draw():
	var m = avatar_margin
	var g = avatar_lt_gap
	var s = border_size
	var r = radius_lbrt
	
	var w = border_line_width
	var d = border_diagonal_width
	
	draw_background(m, g, s, r, w, d, PackedColorArray([background_color]))
	draw_borders(m, g, s, r, w, d, PackedColorArray([border_color]))


func draw_background(m: float, g: float, s: float, r: float, w: float, d: float, cs: PackedColorArray):
	draw_polygon(
		PackedVector2Array([
			Vector2(2*m+g, 0),
			Vector2(s-r, 0),
			Vector2(s-r, r),
			Vector2(s, r),
			Vector2(s, s-2*m-g),
			Vector2(s-2*m-g, s),
			Vector2(r, s),
			Vector2(r, s-r),
			Vector2(0, s-r),
			Vector2(0, 2*m+g),
		]),
		cs,
	)
	draw_circle(Vector2(r, s-r), r-0.5, background_color)
	draw_circle(Vector2(s-r, r), r-0.5, background_color)
	pass


func draw_borders(m: float, g: float, s: float, r: float, w: float, d: float, cs: PackedColorArray):
#	# top
	draw_polygon(
		PackedVector2Array([
			Vector2(2*m+g, 0),
			Vector2(s-r, 0),
			Vector2(s-r, 1),
			Vector2(2*m+g, 1),
		]),
		cs,
	)
	
	# top-right
	draw_arc(
		Vector2(s-r, r),
		r - 0.5,
		-PI / 2,
		0,
		128,
		border_color,
		1,
	)
	
	# right
	draw_polygon(
		PackedVector2Array([
			Vector2(s-1, r),
			Vector2(s-1, s-2*m-g),
			Vector2(s, s-2*m-g),
			Vector2(s, r),
		]),
		cs,
	)
	
	# right-bottom
	draw_polygon(
		PackedVector2Array([
			Vector2(s, s-2*m-g-d),
			Vector2(s, s-2*m-g),
			Vector2(s-2*m-g, s),
			Vector2(s-2*m-g-d, s),
		]),
		cs,
	)
	
	# bottom
	draw_polygon(
		PackedVector2Array([
			Vector2(r, s-1),
			Vector2(s-2*m-g, s-1),
			Vector2(s-2*m-g, s),
			Vector2(r, s),
		]),
		cs,
	)
	
	# left-bottom
	draw_arc(
		Vector2(r, s-r),
		r - 0.5,
		PI,
		PI / 2,
		128,
		border_color,
		1,
	)
	
	# left
	draw_polygon(
		PackedVector2Array([
			Vector2(0, 2*m+g),
			Vector2(1, 2*m+g),
			Vector2(1, s-r),
			Vector2(0, s-r),
		]),
		cs,
	)
	
	# left-top
	draw_polygon(
		PackedVector2Array([
			Vector2(2*m+g, 0),
			Vector2(2*m+g+d, 0),
			Vector2(0, 2*m+g+d),
			Vector2(0, 2*m+g),
		]),
		cs,
	)
	
	pass

