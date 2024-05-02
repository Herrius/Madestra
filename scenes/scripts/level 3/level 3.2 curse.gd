extends "res://scenes/scripts/level 3/level 3.1 curse.gd"

func _ready():
    UiScreen.contador+=1
    if UiScreen.contador==4:
        $MainMiniGame.movimiento_px=0
        UiScreen.change_scene("res://scenes/level/level 3.3 curse.tscn")

