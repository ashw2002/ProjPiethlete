extends Node
@export var CrowRef: PackedScene
@export var TwrRef: PackedScene
var money = 0
var PlayerHealth = 20
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
var SelProxy
var TwrTexList
var CrwTexList
var NoiMkr
# Called when the node enters the scene tree for the first time.
func _ready():
	CamRef = $Camera
	SelProxy = $SelectorProxy
	NoiMkr = $AudioStreamPlayer2D
	ModifyMoney(2000)
	LdTwrJson = JSON.parse_string(FileAccess.open(TwrResrcFl, FileAccess.READ).get_as_text())
	LdCrowJson = JSON.parse_string(FileAccess.open(CrwResrcFl, FileAccess.READ).get_as_text())
	LdMapJson = JSON.parse_string(FileAccess.open(MapResrcFl, FileAccess.READ).get_as_text())
	mapPath = load(LdMapJson[str(curMap)]["MapPath"])
	TwrTexList = [load(LdTwrJson[str(0)]["sprite"]),load(LdTwrJson[str(1)]["sprite"]),load(LdTwrJson[str(2)]["sprite"]),load(LdTwrJson[str(3)]["sprite"]),load(LdTwrJson[str(4)]["sprite"])]
	CrwTexList = [load(LdCrowJson[str(0)]["sprite"]),load(LdCrowJson[str(1)]["sprite"]),load(LdCrowJson[str(2)]["sprite"]),load(LdCrowJson[str(3)]["sprite"]),load(LdCrowJson[str(4)]["sprite"])]
	
	#print_debug(LdTwrJson["0"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass #print_debug(get_viewport().get_mouse_position())

func SpawnCrow(crowType):
	var StsToGrab = LdCrowJson[str(crowType)]
	var mob = CrowRef.instantiate()
	mob.add_to_group("Enemies")
	mob.setStats(StsToGrab["health"], StsToGrab["speed"], StsToGrab["worth"], StsToGrab["resistence"], CrwTexList[crowType])
	#print_debug(mapPath)
	mob.setPath(mapPath)
	add_child(mob)

func SpawnTower(TowerType,TwrPos):
	var StsToGrab = LdTwrJson[str(TowerType)]
	#print_debug(StsToGrab["name"])
	if StsToGrab["cost"] <= money:
		ModifyMoney(StsToGrab["cost"] * -1)
		var TmpTwr = TwrRef.instantiate()
		TmpTwr.ApplyStats(StsToGrab["range"],StsToGrab["cool"],StsToGrab["dmg"], StsToGrab["type"], TwrTexList[TowerType])
		TmpTwr.position = TwrPos
		add_child(TmpTwr)

func _input(event):
	#print_debug("InputDetected")
	if event.is_action_pressed("SpacePress"):
		#print_debug("SpawningCrow")
		SpawnCrow(0)
	elif event.is_action_pressed("LeftClick") && isPlacing:
		#print_debug("Spawning Tower")
		if SelProxy.isPlacable():
			SpawnTower(SelTwr, get_viewport().get_mouse_position())
			isPlacing = false
			SelProxy.deactivate()
func ModifyMoney(amt):
	money += amt
	CamRef.UpdateMoney(money)

func SelectTowerID(id):
	SelProxy.deactivate()
	SelTwr = id
	isPlacing = true
	SelProxy.activate(LdTwrJson[str(id)]["range"],TwrTexList[id])

func SpawnWave(MapID, WaveID):
	var MapStats =LdMapJson[str(MapID)]
	#print_debug(MapStats[WaveID])
	for i in range(MapStats[WaveID].size()):
		SpawnCrow(MapStats[WaveID][i])
		await get_tree().create_timer(1).timeout
		
func RunMap(MapID):
	var MapStats = LdMapJson[str(MapID)]
	NoiMkr.stream = load("res://Resources/BGM/WesternAfrican - Prey Loop.wav")
	NoiMkr.playing = true
	for i in range(MapStats["NumWaves"]):
		#print_debug("Spawning Wave: " + str(i))
		SpawnWave(MapID, "wave" + str(i))
		#print_debug("Waiting for 30 sec")
		await get_tree().create_timer(30).timeout
		#print_debug("Done Waiting")

func Deselect():
	isPlacing = false
	SelProxy.deactivate()

func LoseHealth():
	PlayerHealth -= 1
	CamRef.UpdateHealth(PlayerHealth)
	if PlayerHealth <= 0:
		CamRef.Lose()
		get_tree().paused = true
