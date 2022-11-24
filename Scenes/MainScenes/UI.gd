extends CanvasLayer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var lifes = 50


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/Lifes.text = "Lifes: " + str(lifes)
	
#	print("num enemies: ", get_tree().get_nodes_in_group("enemies").size())
##	<emitting_node>.connect("signal_name", <target_node>, "target_method_name")
#	for e in get_tree().get_nodes_in_group("enemies"):
#		e.connect("kamikaze", self, "lossLife")
		
	pass # Replace with function body.

func lossLife(dmg):
	lifes -= dmg
	$HUD/Lifes.text = "Lifes: " + str(lifes)
	
	if(lifes <= 0):
		gameOver()
		

func gameOver():
	var handler = self.get_parent().get_parent()
	var res = ResourceLoader.load("res://Scenes/UIScenes/GameOver.tscn")
	var nextScene = res.instance()
	
	handler.get_node("GameScene").queue_free()
	handler.add_child(nextScene)
	
	
	pass
	
#func _unhandled_input(event: InputEvent) -> void:
#	pass
