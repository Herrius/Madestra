extends Node2D
var car_sprite = preload("res://scenes/characters/car_mini.tscn")

func _ready():
    $Timer.start()

# Este método se llamará cuando el jugador colisione con un carro
func _on_Player_body_entered(body):
    if body.is_in_group("carros"):  # Asegúrate de que el cuerpo es un carro
        restart_level()

func restart_level():
    # Recarga la escena actual
    get_tree().reload_current_scene()

    


func _on_area_2d_body_entered(_body):
    $MainMiniGame.movimiento_px=0
    call_deferred("deferred_add_car")
    UiScreen.change_scene("res://scenes/level/level 3.2 curse.tscn")
    
func deferred_add_car():
    var new_car = car_sprite.instantiate() as CharacterBody2D
    add_child(new_car)
    new_car.global_position = Vector2(56,104) # Ajusta a la posición de inicio deseada
    new_car.speed = 500
    new_car.direction = Vector2.RIGHT
