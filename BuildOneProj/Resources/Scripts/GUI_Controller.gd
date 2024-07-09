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


func _on_button_0_pressed():
	Mstr.SelectTowerID(0)

func _on_button_1_pressed():
	Mstr.SelectTowerID(1)

func _on_button_2_pressed():
	Mstr.SelectTowerID(2)

func _on_button_3_pressed():
	Mstr.SelectTowerID(3)

func _on_button_4_pressed():
	Mstr.SelectTowerID(4)

func _on_button_5_pressed():
	pass # Replace with function body.
