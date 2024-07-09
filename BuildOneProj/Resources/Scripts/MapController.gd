extends Node
@export var CrowRef: PackedScene
@export var TwrRef: PackedScene
var money = 0
var CamRef
# Called when the node enters the scene tree for the first time.
func _ready():
	CamRef = $Camera
	ModifyMoney(20)
	SpawnCrow(CrowRef)
	await get_tree().create_timer(2.0).timeout
	SpawnCrow(CrowRef)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass #print_debug(get_viewport().get_mouse_position())

func SpawnCrow(crowType):
	var mob = crowType.instantiate()
	mob.add_to_group("Enemies")
	add_child(mob)

func SpawnTower(TowerType,TwrPos, TwrRng, TwrCst):
	if TwrCst < money:
		ModifyMoney(TwrCst * -1)
		var TmpTwr = TowerType.instantiate()
		TmpTwr.ApplyStats(TwrRng,1.0,1.0)
		TmpTwr.position = TwrPos
		add_child(TmpTwr)

func _input(event):
	print_debug("InputDetected")
	if event.is_action_pressed("SpacePress"):
		print_debug("SpawningCrow")
		SpawnCrow(CrowRef)
	elif event.is_action_pressed("LeftClick"):
		print_debug("Spawning Tower")
		SpawnTower(TwrRef, get_viewport().get_mouse_position(), 400,10)
func ModifyMoney(amt):
	money += amt
	CamRef.UpdateMoney(money)
