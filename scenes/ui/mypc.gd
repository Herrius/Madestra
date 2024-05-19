extends Control


func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

#pc
func _on_icon_1_pressed():
    UiScreen.get_node("dialogo").visible = true
    UiScreen.get_node("dialogo/HBoxContainer/ColorRect/Label").text = "Don't procrastinate; I need to play the game I installed." 

#document
func _on_icon_2_pressed():
    $VentanaDocumentos/AnimationPlayer.play("Open")
