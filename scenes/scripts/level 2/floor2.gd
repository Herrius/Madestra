extends Node2D
var current_area: String = ""

func _process(_delta):
    if $Player and $Player.is_inside_tree():
        if Input.is_action_just_pressed("interact"):
            handle_interaction()

func handle_interaction():
    match current_area:
        "roomDoorIn":
            await UiScreen.change_position()
            $Player.position=Vector2(1034,177)
        "computerGame":
             UiScreen.change_scene("res://scenes/level/level 3.1 curse.tscn")
            
func _on_ladder_body_entered(_body):
    UiScreen.i=1
    var tween = create_tween()
    tween.tween_property($Player,"speed",0,0.5)
    UiScreen.change_scene("res://scenes/level/level 1 floor 1.tscn")

func _on_room_door_in_body_entered(body):
    if body.name == "Player":
        current_area = "roomDoorIn"

func _on_room_door_out_body_entered(_body):
    await UiScreen.change_position()
    $Player.position=Vector2(296,219)

func _on_room_body_exited(body):
    if body.name == "Player":
        current_area = ""

func _on_computer_game_body_entered(body):
    if body.name == "Player":
        current_area = "computerGame"

func _on_computer_game_body_exited(body):
    if body.name == "Player":
        current_area = ""
