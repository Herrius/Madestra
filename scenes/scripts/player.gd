extends CharacterBody2D
@export var speed = 200
var run=1.5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    #input
    var direction=Input.get_vector("left","right","up","down")
    var is_running = Input.is_action_pressed("run")
    velocity=direction*speed
    if is_running:
        velocity *= run
    move_and_slide()
    update_animation(direction, is_running)
    
func update_animation(direction, is_running):
    var base_animation = ""
    if direction.x > 0:
        base_animation = "walk_right"
    elif direction.x < 0:
        base_animation = "walk_left"
    elif direction.y > 0:
        base_animation = "walk_down"
    elif direction.y < 0:
        base_animation = "walk_top"
    
    if base_animation != "":
        if is_running:
            base_animation = base_animation.replace("walk", "run")
        
        $AnimatedSprite2D.play(base_animation)
    else:
        # Opcional: Manejar el caso en el que el personaje esté parado
        $AnimatedSprite2D.stop()  # O jugar una animación de estar parado si existe
        
   

        

