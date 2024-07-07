extends Area2D
var crowLoc
@export var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#print_debug("Start")
	crowLoc = get_node("CrowPath/CrowLoc")
	OnCrowSpawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	crowLoc.progress += speed
	position = crowLoc.position

func OnCrowSpawn():
	crowLoc.progress_ratio = 0
	position = crowLoc.position


func _on_area_entered(area):
	if area.name == "EndZone":
		#print_debug('ThisBetterWork')
		queue_free()
