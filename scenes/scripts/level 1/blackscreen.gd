extends CanvasLayer

func _on_btn_si_pressed():
    $ConfirmedAction.visible = false
    $SceenTransitation.visible = true
    # Aquí puedes añadir más lógica, como iniciar una animación o un temporizador para ocultar la pantalla de resultado
    $Timer.start()

func _on_btn_no_pressed():
    $ConfirmedAction.visible = false

func _on_timer_timeout():
    $SceenTransitation.visible = false
