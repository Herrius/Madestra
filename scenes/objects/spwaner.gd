extends Node2D
class_name Spawner
@export var car_speed: int = 50
@export var spawn_interval: float = 0.5
@export var max_cars: int = 3
var car_direction: Vector2 = Vector2.RIGHT
var cars = []
var car_sprite = preload("res://scenes/characters/car_mini.tscn")
# Límite para eliminar carros, ajusta según tu escenario
var limit = 256

func _ready():
    var timer = $Timer
    timer.wait_time = spawn_interval
    timer.start()

func _process(delta: float) -> void:
    manage_cars(delta,limit)

func _on_timer_timeout():
    spawn_car(car_sprite,car_speed,max_cars)


func spawn_car(car_scene,car_speed,max_cars):
    if cars.size() < max_cars:
        var new_car = car_scene.instantiate() as CharacterBody2D
        add_child(new_car)
        new_car.global_position = self.global_position # Ajusta a la posición de inicio deseada
        new_car.speed = car_speed
        new_car.direction = car_direction
        cars.append(new_car)

func manage_cars(delta: float,limit):
    for car in cars:
        car.position += car.direction * car.speed * delta
        # Verificar si el carro ha cruzado el límite derecho
        if car.position.x > limit:
            cars.erase(car)
            car.queue_free()
            # Opcionalmente, regenera el carro
            spawn_car(car_sprite,car_speed,max_cars)
