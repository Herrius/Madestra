extends pathcat


func _process(delta):
    if moving:
        progress += speed * delta
        # Comprobar si hemos llegado al final del camino
        if progress_ratio<=0.27:
            $Cat/AnimatedSprite2D.play("walk_down")
        elif progress_ratio<=0.91:
            $Cat/AnimatedSprite2D.play("walk_right")
        elif progress_ratio<=0.99:
            $Cat/AnimatedSprite2D.play("walk_down")
        if progress_ratio >= 0.99:
            progress_ratio = 0.99 # Asegurarse de que no exceda el final
            moving = false # Detener el movimiento
            $Cat/AnimatedSprite2D.play("sleep")
