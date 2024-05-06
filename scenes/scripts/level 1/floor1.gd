extends Node2D


var player_in_task: bool = false
var current_area: String = ""
var botar_done: bool = false  # Indicador de tarea de trapear completada
var lavadero_done: bool = false  # Indicador de tarea de lavadero completada
var comida_done:bool=false
var text:String=""

func _ready():
    $Player.position=UiScreen.posiciones_por_piso[UiScreen.i]
    $Player/AnimatedSprite2D.play("walk_down")

func _process(_delta):
    if $Player and $Player.is_inside_tree():
        if Input.is_action_just_pressed("interact"):
            handle_interaction()

func handle_interaction():
    match current_area:
        "pass2level":
            if UiScreen.task_list < 3:  # Asumiendo que hay 3 tareas a completar
                retreat_player(current_area)
        "lavaderoarea2":
            if player_in_task and not lavadero_done:
                perform_task("Lavando...")
                change_tile_clear(Vector2(83,19),Vector2(5,6))
                lavadero_done = true  # Marcar la tarea de lavadero como completada
                player_in_task = false  # Resetear estado para evitar múltiples interacciones
        "botararea2":
            if player_in_task and not botar_done :
                perform_task("Botando...")
                change_tile_clear(Vector2(86,20),Vector2(1,6))
                botar_done = true  # Marcar la tarea de trapear como completada
                player_in_task = false  # Resetear estado para evitar múltiples interacciones
        "comidagato2":
            if player_in_task and not comida_done and botar_done and lavadero_done :
                perform_task("Agarrando comida de gato...")
                comida_done = true  # Marcar la tarea de trapear como completada
                player_in_task = false  # Resetear estado para evitar múltiples interacciones
                $Player.carrying_cat=true
                $Path2D/PathFollow2D/Cat.visible=false
            else:
                text="I can't take the cat without first washing the dishes and taking out the trash."
                dialoge(text)
                if $Player.speed==0:
                    retreat_player()


func change_tile_clear(position,position_tile):
    var tile_map= $house/TileMap
    var tile_position=position
    var clean_atlas_coords=position_tile
    var new_tile_index=5
    tile_map.set_cell(5, tile_position, 2, clean_atlas_coords)
    
func blackscreen(text_screen):
    var tween = create_tween()
    tween.tween_property($Player,"speed",0,0)
    tween.tween_property(UiScreen.get_node("SceenTransitation"),"visible",true,0)
    UiScreen.get_node("SceenTransitation/ResultScreen/ResultLabel").text=text_screen
    tween.tween_property(UiScreen.get_node("SceenTransitation"),"visible",false,1)
    tween.tween_property($Player,"speed",100,1)

func dialoge(text_screen):
    var tween = create_tween()
    UiScreen.get_node("dialogo").visible = true
    UiScreen.get_node("dialogo/HBoxContainer/ColorRect/Label").text = text_screen 
    tween.tween_property($Player,"speed",0,0)

func show_pass2level_dialogue():
    text="I can't go to my room without first finishing my homework and taking my cat 'Sombra' with me."
    dialoge(text)

func retreat_player(area='cat'):
    var tween = create_tween()
    if area =="pass2level":
        tween.tween_property($Player, "position", $Player.position + Vector2(0, 25), 0.5)
        $Player/AnimatedSprite2D.play("walk_down")
    else:
        tween.tween_property($Player, "position", $Player.position + Vector2(0, -25), 0.5)
        $Player/AnimatedSprite2D.play("walk_top")
    UiScreen.get_node("dialogo").visible = false
    tween.tween_property($Player,"speed",100,0)


func perform_task(text_screen):
    UiScreen._on_timer_timeout(text_screen)
    UiScreen.task_list += 1
    $Player.speed=0
    $Timer.start()
    

# Funciones para manejar la entrada y salida de áreas
func _on_pass_2_level_body_entered(body):
    if body.name == "Player":
        current_area = "pass2level"
        if UiScreen.task_list >=  3:
            $house/pass2level/CollisionShape2D.call_deferred("set", "disabled", true)
        else:
            show_pass2level_dialogue()
            
func _on_comida_gato_2_body_entered(body):
    if body.name == "Player" and not comida_done:
        current_area = "comidagato2"
        player_in_task = true
        $Player/AnimatedSprite2D.play("walk_down_cat")

func _on_lavadero_area_2_body_entered(body):
    if body.name == "Player" and not lavadero_done:
        current_area = "lavaderoarea2"
        player_in_task = true
        

func _on_botar_area_2_body_entered(body):
        if body.name == "Player" and not botar_done:
            current_area = "botararea2"
            player_in_task = true

func _on_area_body_exited(body):
    if body.name == "Player":
        current_area = ""
        player_in_task = false  # Opcional, dependiendo de cómo desees manejar el estado del jugador


func _on_area_2_body_exited(body):
    if body.name == "Player":
        current_area = ""
        player_in_task = false  # Opcional, dependiendo de cómo desees manejar el estado del jugador


func _on_kitchenout_body_entered(body):
    if body.name=="Player":
        $Player.position=Vector2(401,296)
        text=""
        blackscreen(text)

func _on_kitchenin_body_entered(body):
    if body.name=="Player":
        $Player.position=Vector2(1199.508,302.046)
        text=""
        blackscreen(text)

func _on_ladder_body_entered(_body):
    var tween = create_tween()
    tween.tween_property($Player,"speed",0,0.5)
    UiScreen.change_scene("res://scenes/level/level 2 floor 2.tscn")

func _on_timer_timeout():
     $Player.speed=100 


