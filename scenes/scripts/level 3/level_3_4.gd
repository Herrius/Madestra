extends Node2D
var text:String=""
var controlSleep=true
var sleep=false
var current_area: String = ""
var pass3floor=true
# Called when the node enters the scene tree for the first time.
func _ready():
    UiScreen.i=3
    $Player.position=UiScreen.posiciones_por_piso[UiScreen.i]
    $Player/AnimatedSprite2D.play("walk_down")
    $Cat.position=Vector2(929, 132)
    $Cat/AnimatedSprite2D.play("sleep")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if Input.is_action_just_pressed("interact"):
        handle_interaction()

func handle_interaction():
    match current_area:
        "controlSleep":
            if not controlSleep:
                retreat_player("controlSleep")
        "sleeping":
            if not sleep:
                perform_task("Damian is sleeping...")
                sleep=true
                controlSleep=true
        "pass3floor":
            var tween = create_tween()
            tween.tween_property($Player,"speed",0,0.5)
            UiScreen.change_scene("res://scenes/level/level_4.tscn")
                                

func retreat_player(area='cat'):
    var tween = create_tween()
    if area =="controlSleep":
        tween.tween_property($Player, "position", $Player.position - Vector2(0, 25), 0.5)
        $Player/AnimatedSprite2D.play("walk_top")
    UiScreen.get_node("dialogo").visible = false
    tween.tween_property($Player,"speed",100,0)
    $Timer.start()


func dialoge(text_screen):
    var tween = create_tween()
    UiScreen.get_node("dialogo").visible = true
    UiScreen.get_node("dialogo/ColorRect/Label").text = text_screen 
    tween.tween_property($Player,"speed",0,0)

func _on_control_sleep_body_entered(_body):
    current_area = "controlSleep"
    if controlSleep:
        $sleeping/CollisionShape2D.call_deferred("set", "disabled", true)
    else:
        text="I need to go to sleep in my bed."
        dialoge(text)


func _on_sleeping_body_entered(_body):
    if not sleep:
        current_area = "sleeping"
    
func perform_task(text_screen):
    UiScreen._on_timer_timeout(text_screen)
    $Player.speed=0
    $Timer.wait_time=3
    $Timer.start()


func _on_timer_timeout():
     $Player.speed=100


func _on_passage_in_body_entered(_body):
    $Player.speed=0
    await UiScreen.change_position()
    $Player.position=Vector2(296,219)
    $Timer.wait_time=0.5
    $Timer.start()


func _on_arrive_monster_body_entered(_body):
    var tween = create_tween()
    tween.tween_property($Player, "position", $Player.position + Vector2(25, 25), 0.5)
    $Player/AnimatedSprite2D.play("walk_right")
    pass3floor=true


func _on_control_sleep_body_exited(_body):
    current_area = ""


func _on_pass_3_floor_body_entered(_body):
    if pass3floor:
        current_area="pass3floor"
    else:
        current_area=""
