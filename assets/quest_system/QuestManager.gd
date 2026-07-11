extends Node

# Структура задания
class Quest:
	var id: int
	var title: String
	var description: String
	var is_completed: bool = false
	
	func _init(p_id: int, p_title: String, p_description: String):
		id = p_id
		title = p_title
		description = p_description
	
# Структура заметки
class Note:
	var id: int
	var title: String
	var description: String
	var is_completed: bool = false

	func _init(p_id: int, p_title: String, p_description: String):
		id = p_id
		title = p_title
		description = p_description

# Список заданий
var quests: Array[Quest] = []
# Список заметок
var notes: Array[Note] = []

func _ready():
	# Добавляем тестовые задания
	add_quest("Пойти на кухню", "Мама позвала меня на кухню. Интересно, что ей от меня нужно?")
	# Добавляем тестовые заметки
	add_note("Бабочка переросток", "Я Светик и я сегодня завалил гиганскую бабочку переростка. А этот лошара все время мешался под ногами.")
	add_note("Бычара", "Я Светик и я сегодня завалил гиганскую бабочку переростка. А этот лошара все время мешался под ногами.")
	add_note("Черемша", "Я Светик и я сегодня завалил гиганскую бабочку переростка. А этот лошара все время мешался под ногами.")
	add_note("Капибара", "Я Светик и я сегодня завалил гиганскую бабочку переростка. А этот лошара все время мешался под ногами.")

# Функция для добавления нового задания
func add_quest(title: String, desc: String) -> void:
	var new_quest = Quest.new(quests.size(), title, desc)
	quests.append(new_quest)

# Функция для отметки выполнения (по id)
func complete_quest(id: int) -> void:
	for quest in quests:
		if quest.id == id:
			quest.is_completed = true
			print("Задание выполнено: ", quest.title)
			return

# Функция для получения НЕвыполненных заданий (для активного списка)
func get_active_quests() -> Array[Quest]:
	var active: Array[Quest] = []
	for quest in quests:
		if not quest.is_completed:
			active.append(quest)
	return active

# Функция для получения ВСЕХ заданий (для истории)
func get_all_quests() -> Array[Quest]:
	return quests
	
# Завершить задание по названию (первое совпадение)
func complete_quest_by_title(title: String) -> bool:
	for quest in quests:
		if quest.title == title and not quest.is_completed:
			quest.is_completed = true
			print("Задание выполнено: ", quest.title)
			return true
	print("Задание с названием '", title, "' не найдено или уже выполнено")
	return false
	
# ===============
# Функция для добавления новой заметки
func add_note(title: String, desc: String) -> void:
	var new_note = Note.new(quests.size(), title, desc)
	notes.append(new_note)

# Функция для получения заметок
func get_active_notes() -> Array[Note]:
	var active: Array[Note] = []
	for note in notes:
		if not note.is_completed:
			active.append(note)
	return active
