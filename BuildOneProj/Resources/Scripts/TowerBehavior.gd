extends Node2D

@export var TwrRng = 1.0
var Trfm
var Target
var ColShape

# Called when the node enters the scene tree for the first time.
func _ready():
	ColShape = get_node("TowerRange/RangeShape")
	Trfm = Transform2D(self.transform)
	#print_debug(ColShape.shape.radius)
	ColShape.shape.radius = TwrRng
	#print_debug(ColShape.shape.radius)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Target && is_instance_valid(Target):
		look_at(Target.position)


func _on_tower_range_area_entered(area):
	#print_debug("NewTarget?")
	#print_debug(area.get_groups().find("Enemies"))
	if area.get_groups().find("Enemies") >= 0:
		Target = area
		#print_debug("TargetConfirmed")
		
func faceItem(item):
	Trfm.looking_at(item.position)
	print_debug(Trfm)
	print_debug(self.transform)
	
