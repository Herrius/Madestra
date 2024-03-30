extends Spawner

var limit_alt=-256
var car_scene_alt = preload("res://scenes/characters/car_mini.tscn")
var car_speed_alt: int = -50
var max_cars_alt: int = 4

func _process(delta: float) -> void:
    manage_cars(delta,limit_alt)

func _on_timer_timeout():
    spawn_car(car_scene_alt,car_speed_alt,max_cars_alt)

func manage_cars(delta: float,limit):
    for car in cars:
        car.position += car.direction * car.speed * delta
        # Verificar si el carro ha cruzado el límite derecho
        if car.position.x < limit:
            cars.erase(car)
            car.queue_free()
            # Opcionalmente, regenera el carro
            spawn_car(car_scene_alt,car_speed_alt,max_cars_alt)
