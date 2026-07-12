extends CanvasLayer

@onready var quest_container = $Panel/ScrollContainer2/QuestListContainer
@onready var note_container = $Panel/ScrollContainer/NoteListContainer
@onready var close_button = $Panel/Button

# Загружаем префабы задания и заметки
var quest_item_scene = preload("res://assets/quest_system/diary/scenes/QuestItem.tscn")
var note_item_scene = preload("res://assets/quest_system/diary/scenes/NoteItem.tscn")

func _ready():
	# Скрываем ежедневник при старте игры
	visible = false
	# Подключаем кнопку закрытия
	close_button.pressed.connect(_on_close_pressed)

# Функция обновления списка заданий
func update_quest_list():
	# Очищаем старые элементы в контейнере
	for child in quest_container.get_children():
		child.queue_free()
	
	# Получаем активные задания из менеджера
	var active_quests = QuestManager.get_active_quests()
	
	if active_quests.is_empty():
		# Если заданий нет, выводим поздравление
		var label = Label.new()
		label.text = "Нет заданий"
		label.add_theme_color_override("font_color", Color.GREEN)
		quest_container.add_child(label)
	else:
		# Добавляем каждое задание в список
		for quest in active_quests:
			var item = quest_item_scene.instantiate()
			# Находим в дочерних узлах иконку квеста, название и описание
			var statusicon = item.get_node("StatusIcon")
			var mainlabel = item.get_node("VBoxContainer/Header")
			var label = item.get_node("VBoxContainer/Information")
			
			# Заполняем данные
			mainlabel.text = quest.title # Заголовок квеста
			label.text = quest.description # Описание квеста
			
			# Добавляем в список
			quest_container.add_child(item)
			
# Функция обновления списка заметок
func update_note_list():
	# Очищаем старые элементы в контейнере
	for child in note_container.get_children():
		child.queue_free()
	
	# Получаем активные заметки из менеджера
	var active_notes = QuestManager.get_active_notes()
	
	if active_notes.is_empty():
		# Если заметок нет, выводим надпись
		var label = Label.new()
		label.text = "Чего бы такого записать?"
		label.add_theme_color_override("font_color", Color.SADDLE_BROWN)
		note_container.add_child(label)
	else:
		# Добавляем каждую заметку в список
		for note in active_notes:
			var item = note_item_scene.instantiate()
			# Находим в дочерних узлах иконку квеста, название и заметку
			var noteicon = item.get_node("NoteIcon")
			var mainlabel = item.get_node("VBoxContainer/Header")
			var label = item.get_node("VBoxContainer/Note")
			
			# Заполняем данные
			mainlabel.text = note.title # Заголовок квеста
			label.text = note.description # Описание квеста
			
			# Добавляем в список
			note_container.add_child(item)

# Как можно отметить задание как выполненное:
#func _on_quest_toggled(pressed: bool, quest_id: int):
#	if pressed:
#		# Отмечаем задание выполненным
#		QuestManager.complete_quest(quest_id)
#		# Обновляем список, чтобы убрать выполненное задание
#		update_quest_list()

# Закрыть ежедневник
func _on_close_pressed():
	visible = false
	get_tree().paused = false # Если вы ставили паузу, отключаем
	print("Дневник закрыт кнопкой")

# Открыть ежедневник (вызываем извне)
func open_diary():
	update_quest_list() # Перерисовываем список заданий
	update_note_list() # Перерисовываем список заметок
	visible = true
	# Опционально: поставить игру на паузу, чтобы игрок не двигался
	# get_tree().paused = true # не работает
