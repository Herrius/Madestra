extends CanvasLayer
var posiciones_por_piso = {
    0:Vector2(608,99),
    1:Vector2(60,111), 
    2:Vector2(64,166),
    3:Vector2(1039,99),
    4:Vector2(927,99),
    }
var player_in_task: bool = false
var questionaction:bool=false
#0:Vector2(608,99)
var i:int=0
var contador:int=0
@export var carrying_cat=false
@export var task_list: int = 0

    
func _on_timer_timeout(text):
    $SceenTransitation.visible = true
    $SceenTransitation/ResultScreen/ResultLabel.text=text
    # Aquí puedes añadir más lógica, como iniciar una animación o un temporizador para ocultar la pantalla de resultado
    $Timer.start()
    await $Timer.timeout
    $SceenTransitation.visible = false

func change_scene(target: String) -> void:
    $AnimationPlayer.play("fade_to_black")
    await $AnimationPlayer.animation_finished
    get_tree().change_scene_to_file(target)
    $AnimationPlayer.play_backwards("fade_to_black")

func change_position()->void:
    $AnimationPlayer.play("fade_to_black")
    await $AnimationPlayer.animation_finished
    $AnimationPlayer.play_backwards("fade_to_black")



func _input(event):
    if $dialogo.visible: 
        if event is InputEventKey and event.pressed and Input.is_action_just_pressed("interact"):
        # Realiza la acción del diálogo aquí
            $dialogo.visible = false

        elif event is InputEventMouseButton and event.pressed:
        # Realiza la acción del diálogo aquí
            $dialogo.visible = false

    
