extends CharacterBody2D

# Velocidad del movimiento en píxeles
var movimiento_px := 16
# La última dirección de movimiento
var ultima_direccion := Vector2.ZERO

func _physics_process(_delta: float) -> void:
    var direccion = Vector2.ZERO
    
    # Detectar la entrada del usuario para determinar la dirección
    if Input.is_action_just_pressed("right"):
        direccion.x = 1
    elif Input.is_action_just_pressed("left"):
        direccion.x = -1
    elif Input.is_action_just_pressed("down"):
        direccion.y = 1
    elif Input.is_action_just_pressed("up"):
        direccion.y = -1
    
    # Si hay una dirección de movimiento, mover el personaje
    if direccion != Vector2.ZERO:
        ultima_direccion = direccion
        update_animation(direccion)
    mover_personaje(direccion)

func mover_personaje(direccion: Vector2) -> void:
    # Calcula la nueva posición basada en la dirección y la cantidad de movimiento
    var movimiento = direccion * movimiento_px
    # Intenta mover el personaje a la nueva posición y detenerse en caso de colisión
    var collision=move_and_collide(movimiento)
    if collision:
        get_tree().reload_current_scene()


    
func update_animation(direction):
    var base_animation = ""
    if direction.x > 0:
        base_animation = "walk_right"
    elif direction.x < 0:
        base_animation = "walk_left"
    elif direction.y > 0:
        base_animation = "walk_down"
    elif direction.y < 0:
        base_animation = "walk_up"
    
    if base_animation != "":
        $AnimatedSprite2D.play(base_animation)
    else:
        $AnimatedSprite2D.stop()  # Detiene la animación si el personaje está paradoa la solucion que planteas

