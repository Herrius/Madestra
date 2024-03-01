extends Node2D

@export var task_list: int = 0
var player_in_task: bool = false
var current_area: String = ""
var ui_scene: PackedScene = preload("res://scenes/ui/blackscreen.tscn")

func _ready():
    move_cat_to_position()
    
func move_cat_to_position():
    var tween = create_tween()
    tween.tween_property($Cat,"position",$Cat.position + Vector2(0,150),3)
    $Cat.update_animation("walk_down")
    tween.tween_property($Cat,"position",$Cat.position + Vector2(-150,0),3)
    $Cat.update_animation("walk_right")
    tween.tween_property($Cat,"position",$Cat.position + Vector2(0,25),3)
    $Cat.update_animation("walk_down")
    tween.tween_property($Cat,"position",$Cat.position + Vector2(50,0),3)
    $Cat.update_animation("walk_right")
    
func _process(_delta):
    if $Player and $Player.is_inside_tree():
        if Input.is_action_just_pressed("interact"):
            handle_interaction()

func handle_interaction():
    match current_area:
        "pass2level":
            if task_list < 3:  # Asumiendo que hay 3 tareas a completar
                retreat_player()
        "lavaderoarea2", "trapeararea2":
            if player_in_task:
                perform_task()
                player_in_task = false  # Resetear estado para evitar múltiples interacciones

func show_pass2level_dialogue():
    var tween = create_tween()
    $Blackscreen/dialogo.visible = true
    $Blackscreen/dialogo/ColorRect/Label.text = "No puedo ir a mi cuarto sin antes acabar los deberes"
    tween.tween_property($Player,"speed",0,0)

func retreat_player():
    var tween = create_tween()
    tween.tween_property($Player, "position", $Player.position + Vector2(0, -25), 0.5)
    $Player/AnimatedSprite2D.play("walk_top")
    $Blackscreen/dialogo.visible = false
    tween.tween_property($Player,"speed",200,0)

func perform_task():
    task_list += 1
    $Blackscreen/ConfirmedAction.visible = true
    # Aquí puedes agregar la transición de pantalla si es necesario

# Funciones para manejar la entrada y salida de áreas
func _on_pass_2_level_body_entered(body):
    if body.name == "Player":
        current_area = "pass2level"
        if task_list>=  3:
            $house/pass2level/CollisionShape2D.disabled=true
        else:
            show_pass2level_dialogue()
        
func _on_trapear_area_2_body_entered(body):
    if body.name == "Player":
        current_area = "trapeararea2"
        player_in_task = true
       

func _on_lavadero_area_2_body_entered(body):
    if body.name == "Player":
        current_area = "lavaderoarea2"
        player_in_task = true

func _on_area_body_exited(body):
    if body.name == "Player":
        current_area = ""
        player_in_task = false  # Opcional, dependiendo de cómo desees manejar el estado del jugador


func _on_area_2_body_exited(body):
    if body.name == "Player":
        current_area = ""
        player_in_task = false  # Opcional, dependiendo de cómo desees manejar el estado del jugador
