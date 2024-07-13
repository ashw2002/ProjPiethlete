extends Area2D

var target 
@export var speed = 1000
@export var damage = 1
var dmgType
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target && is_instance_valid(target):
		look_at(target.position)
		position += speed * delta * Vector2.RIGHT
	else:
		queue_free()
func SetTarget(item):
	target = item
	
func SetType(typ):
	dmgType = typ

func SetDamage(dmg):
	damage = dmg
	
func SetSpeed(spd):
	speed = spd
	
func _on_area_entered(area):
	if area == target:
		area.TakeDamage(damage,dmgType)
		queue_free()
