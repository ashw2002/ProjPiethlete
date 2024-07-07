extends Node
@export var CrowRef: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	SpawnCrow(CrowRef)
	await get_tree().create_timer(2.0).timeout
	SpawnCrow(CrowRef)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func SpawnCrow(crowType):
	var mob = crowType.instantiate()
	mob.add_to_group("Enemies")
	add_child(mob)

func _input(event):
	if event.is_action_pressed("SpacePress"):
		SpawnCrow(CrowRef)
