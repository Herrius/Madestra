extends PathFollow2D

var speed = 50 # La velocidad de movimiento, ajustar según necesidad
var moving = true # Un interruptor para iniciar/detener el movimiento

func _ready():
    # Asegurarse de que el PathFollow2D comience en el inicio del camino
    progress_ratio = 0
    rotates = false

func _process(delta):
    progress += speed * delta
    $CharacterBody2D/AnimatedSprite2D.play("default")


func _on_kitchenin_body_entered(_body):
    queue_free()
