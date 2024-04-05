extends Spawner

var car_scene_alt = preload("res://scenes/characters/trailer_mini_.tscn")
var max_cars_alt: int = 3

func _process(delta: float) -> void:
    manage_cars(delta,limit)

func _on_timer_timeout():
    spawn_car(car_scene_alt,car_speed,max_cars_alt,0)

func manage_cars(delta: float,limit):
    for car in cars:
        car.position += car.direction * car.speed * delta
        # Verificar si el carro ha cruzado el límite derecho
        if car.position.x > limit:
            cars.erase(car)
            car.queue_free()
            # Opcionalmente, regenera el carro
            spawn_car(car_scene_alt,car_speed,max_cars_alt,0)
