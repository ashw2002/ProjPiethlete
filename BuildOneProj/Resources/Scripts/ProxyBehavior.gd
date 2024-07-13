extends Node2D

var rangeRep
var image
var canPlace = true
var curTex
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	image = get_child(0)
	image.self_modulate.a = .5
	rangeRep = get_child(1).get_child(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		position = get_viewport().get_mouse_position()
	
func _draw():
	rangeRep.shape.draw(get_canvas_item(),Color(1,0,0,.01))

func activate(radius,tex):
	rangeRep.shape.radius = radius
	curTex = tex
	image.texture = curTex
	visible = true

func deactivate():
	visible = false

func isPlacable():
	return canPlace

func _on_phys_rep_area_entered(area):
	if area.name == "Unplacable":
		canPlace = false


func _on_phys_rep_area_exited(area):
	if area.name == "Unplacable":
		canPlace = true
