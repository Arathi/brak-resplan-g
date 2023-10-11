extends Object


enum CombatClass {
	Striker,
	Special,
}


enum Role {
	Dealer,
	Tank,
	Healer,
	Support,
	TacticalSupport,
}


enum AttackType {
	Explosive,
	Piercing,
	Mystic,
	Sonic,
}


enum ArmorType {
	Light,
	Heavy,
	Special,
	Elastic,
}


# 编号
var id: int

# 名称
var name: String

# 稀有度
var rarity: int

# 部队类型
var combat_class: CombatClass

# 职责
var role: Role

# 攻击类型
var attack_type: AttackType

# 护甲类型
var armor_type: ArmorType

# 背景图片
var background: String


