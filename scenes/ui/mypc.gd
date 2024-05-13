extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_icon_1_pressed():
    UiScreen.get_node("dialogo").visible = true
    UiScreen.get_node("dialogo/HBoxContainer/ColorRect/Label").text = "Don't procrastinate; I need to play the game I installed." 


