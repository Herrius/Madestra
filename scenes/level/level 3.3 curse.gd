extends Node2D
var car_sprite = preload("res://scenes/characters/car_mini.tscn")

func _ready():
    $Timer.start()

func _on_area_2d_body_entered(_body):
    $MainMiniGame.movimiento_px=0
    call_deferred("deferred_add_car")
    $Timer.wait_time=0.1
    $Timer.one_shot=true
    $Timer.start()
    await $Timer.timeout
    UiScreen.change_scene("res://scenes/level/level_3_4.tscn")
    
func deferred_add_car():
    var new_car = car_sprite.instantiate() as CharacterBody2D
    add_child(new_car)
    new_car.global_position = Vector2(56,104) # Ajusta a la posición de inicio deseada
    new_car.speed = 350
    new_car.direction = Vector2.RIGHT
