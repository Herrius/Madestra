extends Label

# Define los tamaños mínimo y máximo de la fuente
@export var min_font_size: int = 10
@export var max_font_size: int = 40

func _ready():
    # Asegúrate de que el texto se recorta si es necesario
    update_font_size()
func _process(delta):
    update_font_size()
    
func update_font_size():
    var current_font_size = max_font_size
    add_theme_font_size_override("font_size", current_font_size)
    
    while get_visible_line_count() < get_line_count() and current_font_size > min_font_size:
        current_font_size -= 1
        add_theme_font_size_override("font_size", current_font_size)

    if current_font_size < min_font_size:
        current_font_size = min_font_size
        add_theme_font_size_override("font_size", current_font_size)
