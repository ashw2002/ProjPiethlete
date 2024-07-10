extends Node
@export var CrowRef: PackedScene
@export var TwrRef: PackedScene
var money = 0
var CamRef
var TwrResrcFl = "res://Resources/Scripts/TowerStats.json"
var CrwResrcFl = "res://Resources/Scripts/CrowStats.json"
var MapResrcFl = "res://Resources/Scripts/MapStats.json"
var SelTwr = 0
var LdTwrJson
var LdCrowJson
var LdMapJson
var isPlacing = false
var curMap = 1
var mapPath

# Called when the node enters the scene tree for the first time.
func _ready():
	CamRef = $Camera
	ModifyMoney(2000)
	LdTwrJson = JSON.parse_string(FileAccess.open(TwrResrcFl, FileAccess.READ).get_as_text())
	LdCrowJson = JSON.parse_string(FileAccess.open(CrwResrcFl, FileAccess.READ).get_as_text())
	LdMapJson = JSON.parse_string(FileAccess.open(MapResrcFl, FileAccess.READ).get_as_text())
	mapPath = load(LdMapJson[str(curMap)]["MapPath"])
	RunMap(curMap)
	
	#print_debug(LdTwrJson["0"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass #print_debug(get_viewport().get_mouse_position())

func SpawnCrow(crowType):
	var StsToGrab = LdCrowJson[str(crowType)]
	var mob = CrowRef.instantiate()
	mob.add_to_group("Enemies")
	mob.setStats(StsToGrab["health"], StsToGrab["speed"], StsToGrab["worth"], StsToGrab["resistence"])
	print_debug(mapPath)
	mob.setPath(mapPath)
	add_child(mob)

func SpawnTower(TowerType,TwrPos):
	var StsToGrab = LdTwrJson[str(TowerType)]
	#print_debug(StsToGrab["name"])
	if StsToGrab["cost"] <= money:
		ModifyMoney(StsToGrab["cost"] * -1)
		var TmpTwr = TwrRef.instantiate()
		TmpTwr.ApplyStats(StsToGrab["range"],StsToGrab["cool"],StsToGrab["dmg"], StsToGrab["type"])
		TmpTwr.position = TwrPos
		add_child(TmpTwr)

func _input(event):
	#print_debug("InputDetected")
	if event.is_action_pressed("SpacePress"):
		#print_debug("SpawningCrow")
		SpawnCrow(0)
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

func SpawnWave(MapID, WaveID):
	var MapStats =LdMapJson[str(MapID)]
	print_debug(MapStats[WaveID])
	for i in range(MapStats[WaveID].size()):
		SpawnCrow(MapStats[WaveID][i])
		await get_tree().create_timer(1).timeout
func RunMap(MapID):
	var MapStats = LdMapJson[str(MapID)]
	for i in range(MapStats["NumWaves"]):
		print_debug("Spawning Wave: " + str(i))
		SpawnWave(MapID, "wave" + str(i))
		print_debug("Waiting for 30 sec")
		await get_tree().create_timer(30).timeout
		print_debug("Done Waiting")
