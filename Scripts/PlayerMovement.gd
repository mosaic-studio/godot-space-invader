extends CharacterBody2D

const SPEED = 200.0
@export var Bullet: PackedScene
@onready var Camera = get_node("Camera2D")
@export var fire_rate = 0.2
var actual_rate = 0.2
var timer = 0

var power = false
var power_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _move():
	var direction_x = Input.get_axis("Left", "Right")
	var direction_y = Input.get_axis("Up", "Down")
	velocity.x = 0
	velocity.y = 0
	
	if direction_x:
		velocity.x = direction_x * SPEED
	if direction_y:
		velocity.y = direction_y * SPEED
		
	self.look_at(get_global_mouse_position())
	
	move_and_slide()

func _shoot(delta: float):
	timer += delta
	# Power up that you can get :D
	if power == true:
		power_timer += delta
		actual_rate = fire_rate / 2
		if power_timer >= 10:
			power = false
	else:
		actual_rate = fire_rate
		power_timer = 0
		
	if Input.get_action_raw_strength("Shoot") && timer >= actual_rate:
		var temp = Bullet.instantiate()
		add_sibling(temp)
		temp.global_position = get_node("BulletSpawn").get("global_position")
		# this sets the rotation as to where it will fire
		temp.set("area_direction", (get_global_mouse_position() - self.global_position).normalized())
		# These statements below handle camera shake
		Camera.set("offset", Vector2(randf_range(-4, 4), randf_range(-4, 4)))
		timer = 0
	else:
		Camera.set("offset", Vector2(0, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	_shoot(delta)
	_move()
