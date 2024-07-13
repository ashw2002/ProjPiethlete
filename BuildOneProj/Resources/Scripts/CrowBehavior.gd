extends Area2D
var crowLoc
@export var speed = 1
@export var maxHealth = 1
@export var worth = 1
var resist
var health
var Mstr
var AnmSprt
var SprtFrms

# Called when the node enters the scene tree for the first time.
func _ready():
	#print_debug("Start")
	Mstr = get_tree().get_nodes_in_group("master")[0]
	#print_debug(Mstr)
	crowLoc = get_node("CrowPath/CrowLoc")
	AnmSprt = get_child(0)
	AnmSprt.sprite_frames = SprtFrms
	OnCrowSpawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	crowLoc.progress += speed
	PointForward()
	position = crowLoc.position


func OnCrowSpawn():
	health = maxHealth
	crowLoc.progress_ratio = 0
	position = crowLoc.position

func setStats(hlth, spd, wth, rst,frm):
	maxHealth = hlth
	speed = spd
	worth = wth
	resist = rst
	SprtFrms = frm

func setPath(path):
	get_child(1).curve = path

func _on_area_entered(area):
	if area.name == "EndZone":
		#print_debug('ThisBetterWork')
		Mstr.LoseHealth()
		queue_free()
func TakeDamage(dam,typ):
	if resist == typ:
		health -= ceil(dam/2)
	else:
		health -= dam
	if health <= 0:
		Mstr.ModifyMoney(worth)
		queue_free()

func PointForward():
	var posDelta = crowLoc.position - position
	if abs(posDelta.x) > abs(posDelta.y):
		if posDelta.x > 0:
			AnmSprt.animation = "Right"
		else:
			AnmSprt.animation = "Left"
	else:
		if posDelta.y > 0:
			AnmSprt.animation = "Down"
		else:
			AnmSprt.animation = "Up"
