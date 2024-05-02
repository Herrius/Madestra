extends Node2D
var text:String=""
var controlSleep=false
var sleep=false
var current_area: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
    UiScreen.i=3.4
    $Player.position=UiScreen.posiciones_por_piso[UiScreen.i]
    $Player/AnimatedSprite2D.play("walk_top")
    $Cat/AnimatedSprite2D.play("sleep")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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

func _on_control_sleep_body_entered(body):
    current_area = "controlSleep"
    if controlSleep:
        $sleeping/CollisionShape2D.disabled=true
    else:
        text="I need to go to sleep in my bed."
        dialoge(text)


func _on_sleeping_body_entered(body):
    if not sleep:
        current_area = "sleeping"
    
func perform_task(text_screen):
    UiScreen.get_node("ConfirmedAction").visible = true 
    UiScreen.get_node("SceenTransitation/ResultScreen/ResultLabel").text = text_screen
    $Player.speed=0
    $Timer.start()


func _on_timer_timeout():
     $Player.speed=100
