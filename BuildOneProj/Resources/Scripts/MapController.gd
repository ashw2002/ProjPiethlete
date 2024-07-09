extends Node
@export var CrowRef: PackedScene
@export var TwrRef: PackedScene
var money = 0
var CamRef
var TwrResrcFl = "res://Resources/Scripts/TowerStats.json"
var SelTwr = 0
var LdJson
var isPlacing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	CamRef = $Camera
	ModifyMoney(2000)
	LdJson = JSON.parse_string(FileAccess.open(TwrResrcFl, FileAccess.READ).get_as_text())
	#print_debug(LdJson["0"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass #print_debug(get_viewport().get_mouse_position())

func SpawnCrow(crowType):
	var mob = crowType.instantiate()
	mob.add_to_group("Enemies")
	add_child(mob)

func SpawnTower(TowerType,TwrPos):
	var StsToGrab = LdJson[str(TowerType)]
	#print_debug(StsToGrab["name"])
	if StsToGrab["cost"] <= money:
		ModifyMoney(StsToGrab["cost"] * -1)
		var TmpTwr = TwrRef.instantiate().duplicate()
		TmpTwr.ApplyStats(StsToGrab["range"],StsToGrab["cool"],StsToGrab["dmg"])
		TmpTwr.position = TwrPos
		add_child(TmpTwr)

func _input(event):
	#print_debug("InputDetected")
	if event.is_action_pressed("SpacePress"):
		#print_debug("SpawningCrow")
		SpawnCrow(CrowRef)
	elif event.is_action_pressed("LeftClick") && isPlacing:
		#print_debug("Spawning Tower")
		SpawnTower(SelTwr, get_viewport().get_mouse_position())
		isPlacing = false
func ModifyMoney(amt):
	money += amt
	CamRef.UpdateMoney(money)

func SelectTowerID(id):
	SelTwr = id
	isPlacing = true
