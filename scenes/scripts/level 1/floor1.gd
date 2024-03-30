extends Node2D

@export var task_list: int = 5
var player_in_task: bool = false
var current_area: String = ""
var botar_done: bool = false  # Indicador de tarea de trapear completada
var lavadero_done: bool = false  # Indicador de tarea de lavadero completada
var comida_done:bool=false
var text:String=""

func _ready():
    $Player.position=UiScreen.posiciones_por_piso[UiScreen.i]

func _process(_delta):
    if $Player and $Player.is_inside_tree():
        if Input.is_action_just_pressed("interact"):
            handle_interaction()

func handle_interaction():
    match current_area:
        "pass2level":
            if task_list < 3:  # Asumiendo que hay 3 tareas a completar
                retreat_player()
        "lavaderoarea2":
            if player_in_task and not lavadero_done:
                perform_task("Lavando...")
                lavadero_done = true  # Marcar la tarea de lavadero como completada
                player_in_task = false  # Resetear estado para evitar múltiples interacciones
        "botararea2":
            if player_in_task and not botar_done:
                perform_task("Botando...")
                botar_done = true  # Marcar la tarea de trapear como completada
                player_in_task = false  # Resetear estado para evitar múltiples interacciones
        "comidagato2":
            if player_in_task and not comida_done:
                perform_task("Agarrando comida de gato...")
                comida_done = true  # Marcar la tarea de trapear como completada
                player_in_task = false  # Resetear estado para evitar múltiples interacciones
                
func blackscreen(text_screen):
    var tween = create_tween()
    tween.tween_property($Player,"speed",0,0)
    tween.tween_property($Blackscreen/SceenTransitation,"visible",true,0)
    $Blackscreen/SceenTransitation/ResultScreen/ResultLabel.text=text_screen
    tween.tween_property($Blackscreen/SceenTransitation,"visible",false,1)
    tween.tween_property($Player,"speed",100,1)

func dialoge(text_screen):
    var tween = create_tween()
    $Blackscreen/dialogo.visible = true
    $Blackscreen/dialogo/ColorRect/Label.text = text_screen 
    tween.tween_property($Player,"speed",0,0)

func show_pass2level_dialogue():
    text="No puedo ir a mi cuarto sin antes acabar los deberes"
    dialoge(text)

func retreat_player():
    var tween = create_tween()
    tween.tween_property($Player, "position", $Player.position + Vector2(0, 25), 0.5)
    $Player/AnimatedSprite2D.play("walk_down")
    $Blackscreen/dialogo.visible = false
    tween.tween_property($Player,"speed",100,0)

func perform_task(text_screen):
    task_list += 1
    $Blackscreen/ConfirmedAction.visible = true
    $Blackscreen/SceenTransitation/ResultScreen/ResultLabel.text = text_screen
    $Player.speed=0
    $Timer.start()
    # Aquí puedes agregar la transición de pantalla si es necesario

# Funciones para manejar la entrada y salida de áreas
func _on_pass_2_level_body_entered(body):
    if body.name == "Player":
        current_area = "pass2level"
        if task_list>=  3:
            $house/pass2level/CollisionShape2D.call_deferred("set", "disabled", true)

        else:
            show_pass2level_dialogue()
            
func _on_comida_gato_2_body_entered(body):
    if body.name == "Player" and not comida_done:
        current_area = "comidagato2"
        player_in_task = true

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
    print("saliendo de cocina")
    if body.name=="Player":
        $Player.position=Vector2(401,296)
        text=""
        blackscreen(text)

func _on_kitchenin_body_entered(body):
    print("entrando de cocina")
    if body.name=="Player":
        $Player.position=Vector2(1199.508,302.046)
        text=""
        blackscreen(text)

func _on_ladder_body_entered(_body):
    UiScreen.i=2
    var tween = create_tween()
    tween.tween_property($Player,"speed",0,0.5)
    UiScreen.change_scene("res://scenes/level/level 2 floor 2.tscn")


func _on_timer_timeout():
     $Player.speed=100 


