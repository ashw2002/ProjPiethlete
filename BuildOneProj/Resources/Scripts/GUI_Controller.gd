extends Node

var Mstr
var MonTxtRef
var HlthTxtRef
var LoseText
# Called when the node enters the scene tree for the first time.
func _ready():
	MonTxtRef = $Control/Control/MoneyLabel
	HlthTxtRef = $Control/Control/HealthLabel
	Mstr = get_tree().get_nodes_in_group("master")[0]
	LoseText = get_child(1)
	LoseText.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func UpdateMoney(Amt):
	MonTxtRef.text = "Money: " + str(Amt)

func UpdateHealth(Amt):
	HlthTxtRef.text = "Health: " + str(Amt)

func Lose():
	LoseText.visible = true

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
	Mstr.Deselect()
