extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var numEnemies = 30
var matchTime = 0

signal gameWon

onready var mob_container = $Navigation/EnemieContainer
onready var target = $Target
onready var mob_scene = preload("res://Scenes/Enemies/UfoP.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()#generate SEED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_StartTimer_timeout() -> void:
	print("GAME START")
	$MobTimer.start()
	$MatchTimer.start()
	pass # Replace with function body.

func _on_MatchTimer_timeout() -> void:
	matchTime+=1
	print(matchTime)
	if mob_container.get_child_count() <= 0:
		if $EndTimer.is_stopped():
			$EndTimer.start()
	else:
		$EndTimer.stop()
	pass # Replace with function body.
	

func _on_EndTimer_timeout() -> void:
	print("GAME WIN")
	emit_signal("gameWon")
	pass # Replace with function body.


func _on_MobTimer_timeout() -> void:
	print("SpawnMob")
	
	if numEnemies > 0:
		numEnemies-=1
	else:
		$MobTimer.stop()
	
	$MobTimer.wait_time = rand_range(1,3)#spawna um mob entre 0 e 3 segundos. Pode ser modificado para variar dificuldade
	
	var mob_position_x = randi() % 7 + 2#posiciona o mob em algum lugar ao longo do eixo X do mapa
	
	var le_mob = mob_scene.instance()
	
	#le_mob.alvo = target
	le_mob.alvoPath = target.get_path()
	
	#mob position
	le_mob.translation.x = mob_position_x
#	le_mob.translation.y = 0.5 #automaticamente ajustado pelo navagent
	le_mob.translation.z = -15.5

	
	mob_container.add_child(le_mob)
	pass # Replace with function body.

