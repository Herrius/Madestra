extends Control
var current_question = 0
var correct_answers = 0
var questions = [
    { "text": "What is the term used to describe a fear of heights?", "answers": ["Acrophobia", "Claustrophobia", "Agoraphobia", "Xenophobia"], "correct": 0 },
    { "text": "Which psychological theory focuses on the importance of unconscious processes and unresolved past conflicts?", "answers": ["Behavioral", "Cognitive", "Psychoanalytic", "Humanistic"], "correct": 2 },
    { "text": "What is the primary function of the neurotransmitter serotonin in the brain?", "answers": ["Regulate mood and anxiety", "Control muscle movement", "Induce sleep", "Increase appetite"], "correct": 0 },
    { "text": "₸ⱨε ₽₹เภ¢เρⱠε øƒ ¢øηƒℓเ¢₸ яε$øⱠน₸เøη ł$ ฿α$ε∂ øη ωₕล₸?", "answers": ["ᎶяᎥᎬf", "ƑᎬᎪя", "ᏢᎪᏁᎥᏟ", "ᏢᎪᏁᏁ"], "correct": -1 },  # Correct es -1 para siempre ser incorrecto
    { "text": "₩ₕค₸ เ$ ₸ⱨε ๓๏$₸ ¢๏๓๓๏η ₽$¥¢ₕ๏Ⱡ๏gเ¢คⱠ яε$₽๏η$ε ₸๏ รⱨ๏¢₭?", "answers": ["Ð€λŦΗ", "฿Ⱡ๏๏๔", "₲яᎥᎬƒ", "ՏนᖴᖴᗴяᎥทᏩ"], "correct": -1 }  # Siempre incorrecto
]
var buttons = []

# Called when the node enters the scene tree for the first time.
func _ready():
    load_question(current_question)
    for i in range(1, 5):
        var button = get_node("VBoxContainer/VBoxContainer/Answer" + str(i))

func load_question(index):
    get_node("VBoxContainer/QuestionLabel").text = questions[index].text
    for i in range(4):
        var button_path = "VBoxContainer/VBoxContainer/Answer" + str(i + 1)
        var button = get_node(button_path)
        button.text = questions[index].answers[i]
        button.modulate = Color(1, 1, 1)  # Reset to white color
        
func _on_Answer_selected(answer_index):
    var correct_answer = questions[current_question].correct
    for i in range(4):
        var button_path = "VBoxContainer/VBoxContainer/Answer" + str(i + 1)
        var button = get_node(button_path)
        if i == answer_index:
            if i == correct_answer:
                button.modulate = Color(0, 1, 0)  # Green for correct
                correct_answers += 1
            else:
                button.modulate = Color(1, 0, 0)  # Red for incorrect
            break

    await get_tree().create_timer(1.0).timeout
    current_question += 1
    if current_question < questions.size():
        load_question(current_question)
    else:
        show_report()

func show_report():
    # This will show a final report with the number of correct answers
    var report_label_path = "VBoxContainer/QuestionLabel"
    var report_label = get_node(report_label_path)
    report_label.text = "You got " + str(correct_answers) + " out of " + str(questions.size()) + " correct."


func _on_answer_2_pressed(extra_arg_0):
    pass # Replace with function body.
