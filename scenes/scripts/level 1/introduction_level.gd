extends Control

# Variable para almacenar los fragmentos de texto
var text_fragments = [
    "Regresaba a casa tras un día extenuante, agotado por la rigurosa rutina de mis cursos universitarios. Psicopatología, estadística y ética habían consumido casi toda mi energía, dejándome con un único deseo: un merecido descanso. Era una noche tranquila, perfecta para sumergirme en el mundo de los videojuegos y escapar, aunque fuera por un momento, de la presión académica.",
    "La casa estaba inusualmente silenciosa esa noche. Mis padres se habían ido de viaje, dejándome a cargo del cuidado de nuestro hogar. Solo estaba yo, en compañía de Sombra, mi gato y fiel amigo. Él me seguía de cerca, compartiendo la calma y la soledad de la residencia.",
    "Antes de poder relajarme, sabía que tenía que encargarme de los quehaceres. La responsabilidad de mantener todo en orden recaía sobre mí en ausencia de mis padres. Así que, con Sombra a mis talones, me dispuse a realizar las tareas domésticas, anticipando el momento en que podría finalmente sentarme y perderme en mis videojuegos favoritos."
]

var current_fragment = 0

func _ready():
    # Hace que el cursor sea visible si es necesario.
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    update_text()

func _input(event):
    # Condición simplificada para cualquier evento de pulsación de botón o tecla.
    if (event is InputEventMouseButton or event is InputEventKey) and event.pressed:
        current_fragment += 1
        if current_fragment >= text_fragments.size():
            # Cambia a la escena de nivel 1. Asegúrate de que la ruta sea correcta.
            get_tree().change_scene_to_file("res://scenes/level/level 1 floor 1.tscn")
        else:
            update_text()

func update_text():
    # Asegúrate de que este es el camino correcto hacia tu nodo Label dentro del árbol de nodos.
    $ColorRect/Label.text = text_fragments[current_fragment]
