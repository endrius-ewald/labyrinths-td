extends PopupMenu


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var cashAvailable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true
	connect("id_pressed", get_parent().get_parent(), "build_tower")
	
	#Put in process using singleton to make more accurate
	if(cashAvailable >= 300):	
		set_item_disabled(0,false)
	
	if(cashAvailable >= 500):	
		set_item_disabled(1,false)
	
	pass # Replace with function body.

#Need to calls before adding to scene tree
func init(arg1) -> void:
	cashAvailable=arg1
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
