extends CharacterBody2D

const SPEED = 200.0
@onready var Camera = get_node("Camera2D")
var actual_rate = 0.2
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction_x = Input.get_axis("Left", "Right")
	var direction_y = Input.get_axis("Up", "Down")
	print_debug(direction_x)
	# velocity.x = 0
	# velocity.y = 0
	
	if direction_x:
		velocity.x = direction_x * SPEED
	if direction_y:
		velocity.y = direction_y * SPEED
		
	self.look_at(get_global_mouse_position())
	
	move_and_slide()
