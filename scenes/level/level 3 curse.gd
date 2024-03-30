extends Node2D

var car_scene: PackedScene = preload("res://scenes/characters/car_mini_3.tscn")
var ratios = [0, 0.3, 0.6]
var current_index = 2

func _ready():
    $Timer.start()

# Este método se llamará cuando el jugador colisione con un carro
func _on_Player_body_entered(body):
    if body.is_in_group("carros"):  # Asegúrate de que el cuerpo es un carro
        restart_level()

func restart_level():
    # Recarga la escena actual
    get_tree().reload_current_scene()

    
    
#func _on_timer_timeout():
    #if current_index < ratios.size():
        #generate_cars($PathMaster/path1, ratios[current_index])
        #current_index += 1
        #$Timer.start() # Restart the timer if you want to generate the next car after some delay
    #else:
        #$Timer.stop() # Stop the timer if you have generated all cars
#
#func generate_cars(path_node, ratio):
    #var car = car_scene.instantiate() as CharacterBody2D
    #path_node.progress_ratio = ratio
    #path_node.add_child(car)
