extends Spawner

var car_scene_alt = preload("res://scenes/characters/car_mini_3.tscn")
var max_cars_alt: int = 5
var car_speed_alt=200

func _ready():
    var timer = $Timer
    timer.wait_time = 0.25
    timer.start()
    match name:
        "spawner2":
            car_scene_alt = preload("res://scenes/characters/car_mini_2.tscn")
        "spawner3":
            car_scene_alt= preload("res://scenes/characters/car_mini_3.tscn")
        "spawner4":
            car_scene_alt= preload("res://scenes/characters/car_mini_4.tscn")
        "spawner5":
            car_scene_alt= preload("res://scenes/characters/trailer_mini_.tscn")

func _process(delta: float) -> void:
    manage_cars(delta,limit)

func _on_timer_timeout():
    
    spawn_car(car_scene_alt,car_speed_alt,max_cars_alt,180)
            
func manage_cars(delta: float,limit):
    for car in cars:
        car.position += car.direction * car.speed * delta
        # Verificar si el carro ha cruzado el límite derecho
        if car.position.x > limit:
            cars.erase(car)
            car.queue_free()
            # Opcionalmente, regenera el carro
            spawn_car(car_scene_alt,car_speed_alt,max_cars_alt,180)
