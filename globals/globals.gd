# GlobalSignals.gd
extends Node

signal show_dialog(dialog_text)

func emit_show_dialog(text):
    emit_signal("show_dialog", text)
