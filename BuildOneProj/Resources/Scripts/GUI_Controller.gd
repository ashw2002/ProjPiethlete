extends Node

var Mstr
var MonTxtRef
# Called when the node enters the scene tree for the first time.
func _ready():
	MonTxtRef = $Control/Control/TextLabel
	Mstr = get_tree().get_nodes_in_group("master")[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func UpdateMoney(Amt):
	MonTxtRef.text = "Money: " + str(Amt)
