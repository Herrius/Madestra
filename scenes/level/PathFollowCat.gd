extends PathFollow2D

var speed = 50 # La velocidad de movimiento, ajustar según necesidad
var moving = true # Un interruptor para iniciar/detener el movimiento

func _ready():
    # Asegurarse de que el PathFollow2D comience en el inicio del camino
    progress_ratio = 0
    rotates = false

func _process(delta):
    if moving:
        progress += speed * delta
        # Comprobar si hemos llegado al final del camino
        if progress_ratio<=0.35:
            $Cat/AnimatedSprite2D.play("walk_down")
        elif progress_ratio<=0.885:
            $Cat/AnimatedSprite2D.play("walk_left")
        elif progress_ratio>=0.885:
            $Cat/AnimatedSprite2D.play("walk_down")
        if progress_ratio >= 0.99:
            progress_ratio = 0.99 # Asegurarse de que no exceda el final
            moving = false # Detener el movimiento


func _on_kitchenin_body_entered(_body):
    queue_free()
