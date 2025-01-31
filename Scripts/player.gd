extends CharacterBody2D

@export var JUMP_VELOCITY: float = -700.0
@export var SUPER_JUMP_VELOCITY: float = -1000.0

var super_jump = false
var super_jump_timer: Timer

func _ready() -> void:
	super_jump_timer = $SuperJumpTimer

func _process(delta: float) -> void:
	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor() and super_jump_timer.is_stopped():
		super_jump_timer.start()
	
	if Input.is_action_just_released("ui_accept") and is_on_floor():
		velocity.y = SUPER_JUMP_VELOCITY if super_jump else JUMP_VELOCITY
		super_jump_timer.stop()
		super_jump = false
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()


func _on_super_jump_timer_timeout() -> void:
	super_jump = true
