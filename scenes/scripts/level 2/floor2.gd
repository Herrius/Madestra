extends Node2D
var current_area: String = ""
var cat_sprite = preload("res://scenes/characters/cat.tscn")
func _ready():
    $Player.carrying_cat=true
    $Player/AnimatedSprite2D.play("walk_down_cat")


func _process(_delta):
    if $Player and $Player.is_inside_tree():
        if Input.is_action_just_pressed("interact"):
            handle_interaction()

func handle_interaction():
    match current_area:
        "roomDoorIn":
            $Player.speed=0
            await UiScreen.change_position()
            $Player.position=Vector2(1034,177)
            $Timer.start()
        "computerGame":
            if $Player.carrying_cat:
                dialoge("No play a videogame holding Sombra")
            else:
                UiScreen.change_scene("res://scenes/level/level 3.1 curse.tscn")
        "catSleep":
            if $Player.carrying_cat:
                $Player.carrying_cat=false
                var new_cat = cat_sprite.instantiate() as CharacterBody2D
                add_child(new_cat)
                new_cat.position=Vector2(927,132)
                # Acceso directo al AnimatedSprite2D después de instanciar el objeto
                var animated_sprite = new_cat.get_node("AnimatedSprite2D") # Asegúrate de que la ruta al nodo AnimatedSprite2D es correcta
                
                # Configurando la animación
                animated_sprite.animation = "sleep"  # Asegúrate de que "walk" es una animación válida en el AnimatedSprite2D
                animated_sprite.play()
                
func _on_ladder_body_entered(_body):
    UiScreen.i=1
    var tween = create_tween()
    tween.tween_property($Player,"speed",0,0.5)
    UiScreen.change_scene("res://scenes/level/level 1 floor 1.tscn")

func _on_room_door_in_body_entered(body):
    if body.name == "Player":
        current_area = "roomDoorIn"

func _on_room_door_out_body_entered(_body):
    $Player.speed=0
    await UiScreen.change_position()
    $Player.position=Vector2(296,219)
    $Timer.start()

func _on_room_body_exited(body):
    if body.name == "Player":
        current_area = ""

func _on_computer_game_body_entered(body):
    if body.name == "Player":
        current_area = "computerGame"

func _on_computer_game_body_exited(body):
    if body.name == "Player":
        current_area = ""

func _on_cat_sleep_body_entered(body):
    if body.name == "Player":
        current_area = "catSleep"

func dialoge(text_screen):
    var tween = create_tween()
   
    if UiScreen.get_node("dialogo").visible:
        UiScreen.get_node("dialogo").visible = false
        tween.tween_property($Player,"speed",100,0)
    else:
        UiScreen.get_node("dialogo").visible = true
        UiScreen.get_node("dialogo/HBoxContainer/ColorRect/Label").text = text_screen 
        tween.tween_property($Player,"speed",0,0)

func _on_timer_timeout():
     $Player.speed=100
