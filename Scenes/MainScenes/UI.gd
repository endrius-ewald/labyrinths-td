extends CanvasLayer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var bill
onready var lifes = 10
var cash
var game = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	var lvl = get_parent().get_node("Level")
	
	lvl.connect("gameWon",self,"gameWon")
#	print("num enemies: ", get_tree().get_nodes_in_group("enemies").size())
##	<emitting_node>.connect("signal_name", <target_node>, "target_method_name")
#	for e in get_tree().get_nodes_in_group("enemies"):
#		e.connect("kamikaze", self, "lossLife")
		
	pass # Replace with function body.

func _process(delta: float) -> void:
	$HUD/Lifes.text = "Lifes: " + str(lifes)
	$HUD/Cash.text = "Cash: " + str(cash)
	pass


func lossLife(dmg):
	lifes -= dmg
	$HUD/Lifes.text = "Lifes: " + str(lifes)
	
	if(lifes <= 0):
		gameOver()
		
func cashIn(amount):
	cash += amount
	$HUD/Cash.text = "Cash: " + str(cash)
	pass

func gameOver():
	var handler = self.get_parent().get_parent()
	var res = ResourceLoader.load("res://Scenes/UIScenes/GameOver.tscn")
	var nextScene = res.instance()
	
	handler.get_node("GameScene").queue_free()
	handler.add_child(nextScene)
	
	pass
	
func gameWon():
	var handler = self.get_parent().get_parent()
	var res
	
	if(game == 3):
		res = ResourceLoader.load("res://Scenes/UIScenes/GameWon.tscn")
		var nextScene = res.instance()
		handler.get_node("GameScene").queue_free()
		handler.add_child(nextScene)
		
	else:
		res = ResourceLoader.load("res://Scenes/UIScenes/GameNext.tscn")
		var scene = res.instance()
		handler.get_node("GameScene").get_node("UI/HUD").visible = false
		handler.get_node("GameScene").get_node("UI").add_child(scene)
		game+=1
	
	pass
	
#func _unhandled_input(event: InputEvent) -> void:
#	pass

func loadNextMap():
	var handler = self.get_parent().get_parent()
	handler.get_node("GameScene").get_node("UI").get_node("GameNext").queue_free()
	handler.get_node("GameScene").get_node("Level").free()
	
	var res = ResourceLoader.load("res://Scenes/Levels/Level"+str(game)+".tscn")
	var level = res.instance()
	
	handler.get_node("GameScene").get_node("UI/HUD").visible = true
	handler.get_node("GameScene").add_child(level)
	handler.get_node("GameScene")._ready()
	self._ready()
	
	pass


func _on_Button_pressed() -> void:
	if get_tree().paused:
		$HUD/PauseBtn.text = "PAUSE"
		get_tree().paused = false
	else:
		$HUD/PauseBtn.text = "PLAY"
		get_tree().paused = true
	pass # Replace with function body.
