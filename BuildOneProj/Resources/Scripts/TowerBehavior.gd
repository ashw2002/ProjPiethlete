extends Node2D

@export var TwrRng = 1.0
@export var ProjRef: PackedScene
@export var secCool = 1.0
@export var TwrDmg = 1.0
var secRemain = 0
var Targets = Array()
var ColShape


# Called when the node enters the scene tree for the first time.
func _ready():
	ColShape = CollisionShape2D.new()
	ColShape.shape = CircleShape2D.new()
	#print_debug(ColShape.shape)
	get_child(1).add_child(ColShape)
	#print_debug(ColShape.shape.radius)
	ColShape.shape.set_radius(TwrRng)
	#print_debug(ColShape.shape.radius)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Targets.size() > 0) && is_instance_valid(Targets[0]):
		look_at(Targets[0].position)
		if secRemain <= 0:
			ShootProjectile()
			secRemain = secCool
	secRemain -= delta

func ApplyStats(Rng,Cool, Dmg):
	TwrRng = Rng
	secCool = Cool
	TwrDmg = Dmg

func SetRange(rng):
	TwrRng = rng
	ColShape.shape.radius = TwrRng

func _on_tower_range_area_entered(area):
	#print_debug("NewTarget?")
	#print_debug(area.get_groups().find("Enemies"))
	if area.get_groups().find("Enemies") >= 0:
		Targets.push_back(area)
		#print_debug("TargetConfirmed")


func _on_tower_range_area_exited(area):
	#print_debug("Exit Detected")
	if (area.get_groups().find("Enemies") >=0) && (Targets.find(area) >= 0): 
		Targets.erase(area)

func ShootProjectile():
	var projectile = ProjRef.instantiate()
	projectile.SetTarget(Targets[0])
	projectile.add_to_group("Projectiles")
	add_child(projectile)

