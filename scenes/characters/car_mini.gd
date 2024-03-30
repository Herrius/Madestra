extends CharacterBody2D
@export var speed = 10
@export var direction = Vector2.RIGHT
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position += direction * speed * delta


