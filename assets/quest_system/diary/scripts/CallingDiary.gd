extends Sprite2D

# Ссылка на сцену ежедневника
var diary_scene = preload("res://assets/quest_system/diary/scenes/DiaryUI.tscn")
var diary_instance = null

func _ready():
	# Создаем ежедневник один раз и прячем
	diary_instance = diary_scene.instantiate()
	add_child(diary_instance)
	diary_instance.visible = false

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_Q:
		# Проверяем, открыт ли уже ежедневник
		if diary_instance.visible:
			# Если открыт - закрываем (вызываем его же кнопку закрытия)
			diary_instance._on_close_pressed()
			print("Клавиша Q нажата. Дневник закрыт")
		else:
			# Если закрыт - открываем
			diary_instance.open_diary()
			print("Клавиша Q нажата. Дневник открыт")
