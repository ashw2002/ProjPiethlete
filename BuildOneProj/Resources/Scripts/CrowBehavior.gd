extends Area2D
var crowLoc
@export var speed = 1
@export var maxHealth = 1
@export var worth = 1
var health
var Mstr

# Called when the node enters the scene tree for the first time.
func _ready():
	#print_debug("Start")
	Mstr = get_tree().get_nodes_in_group("master")[0]
	#print_debug(Mstr)
	crowLoc = get_node("CrowPath/CrowLoc")
	OnCrowSpawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	crowLoc.progress += speed
	position = crowLoc.position

func OnCrowSpawn():
	health = maxHealth
	crowLoc.progress_ratio = 0
	position = crowLoc.position


func _on_area_entered(area):
	if area.name == "EndZone":
		#print_debug('ThisBetterWork')
		queue_free()
func TakeDamage(dam):
	health -= dam
	if health <= 0:
		Mstr.ModifyMoney(worth)
		queue_free()
