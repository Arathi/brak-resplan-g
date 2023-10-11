extends Node


const Student = preload("res://domains/metadata/student.gd")


var students: Dictionary = {}


func _ready():
	pass


func _process(delta):
	pass


func load_from_schale():
	var content = UserResourceLoader.load_data("students", "zh")
	var dataList = JSON.parse_string(content) as Array
	for data in dataList:
		var student = convert_student(data)
		students[student.id] = student
	
	var list: Array[Student] = []
	for key in students:
		var student: Student = students[key]
		list.append(student)
	
	return list


func convert_student(data) -> Student:
	var student: Student = Student.new()
	student.id = data.Id
	student.name = data.PathName
	student.rarity = data.StarGrade
	
	match data.SquadType:
		"Main": student.combat_class = Student.CombatClass.Striker
		"Support": student.combat_class = Student.CombatClass.Special
	
	match data.TacticRole:
		"DamageDealer": student.role = Student.Role.Dealer
		"Healer": student.role = Student.Role.Healer
		"Supporter": student.role = Student.Role.Support
		"Tanker": student.role = Student.Role.Tank
		"Vehicle": student.role = Student.Role.TacticalSupport
	
	match data.BulletType:
		"Explosion": student.attack_type = Student.AttackType.Explosive
		"Pierce": student.attack_type = Student.AttackType.Piercing
		"Mystic": student.attack_type = Student.AttackType.Mystic
		"Sonic": student.attack_type = Student.AttackType.Sonic
	
	match data.BulletType:
		"LightArmor": student.armor_type = Student.ArmorType.Light
		"HeavyArmor": student.armor_type = Student.ArmorType.Heavy
		"Unarmed": student.armor_type = Student.ArmorType.Special
		"ElasticArmor": student.armor_type = Student.ArmorType.Elastic
	
	student.background = data.CollectionBG
	
	return student

