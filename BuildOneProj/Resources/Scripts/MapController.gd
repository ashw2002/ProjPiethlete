extends Node
@export var CrowRef: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	SpawnCrow(CrowRef)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func SpawnCrow(crowType):
	var mob = crowType.instantiate()
	mob.add_to_group("Enemies")
	add_child(mob)
