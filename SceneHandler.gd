extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("MainMenu/PlayBtn").connect("pressed", self, "onPlayPressed")
	get_node("MainMenu/QuitBtn").connect("pressed", self, "onExitPressed")
	get_node("MainMenu/TutBtn").connect("pressed", self, "onTutorialPressed")
	
	pass # Replace with function body.


func onPlayPressed():
	print("LETS PLAY")
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/GameScene.tscn").instance()
	add_child(game_scene)

func onExitPressed():
	get_tree().quit()

func onTutorialPressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/UIScenes/Tutorial.tscn").instance()
	add_child(game_scene)
