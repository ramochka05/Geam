extends Resource
class_name ItemData

# Название предмета
@export var name: String = ""

# Описание предмета
@export_multiline var description: String = ""

# Иконка предмета (текстура)
@export var icon: Texture2D

# Можно ли складывать этот предмет в одну ячейку (стакать)?
@export var is_stackable: bool = false

# Максимальное количество предметов в стаке (если is_stackable = true)
@export var max_stack_size: int = 99

# Теперь здесь будет не сама сцена, а просто текст с путем к файлу:
@export_file("*.tscn") var drop_scene_path: String
