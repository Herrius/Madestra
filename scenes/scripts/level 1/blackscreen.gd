extends CanvasLayer
var posiciones_por_piso = {0:Vector2(608,99),1: Vector2(60,111), 2: Vector2(64,166)}
#0:Vector2(608,99)
var i:int=0
func _on_btn_si_pressed():
    $ConfirmedAction.visible = false
    $SceenTransitation.visible = true
    # Aquí puedes añadir más lógica, como iniciar una animación o un temporizador para ocultar la pantalla de resultado
    $Timer.start()

func _on_btn_no_pressed():
    $ConfirmedAction.visible = false

func _on_timer_timeout():
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
