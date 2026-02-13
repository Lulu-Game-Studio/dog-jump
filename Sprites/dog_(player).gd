extends CharacterBody2D

# --- CONSTANTS ---
const SPEED := 220.0
const GRAVITY := 1000.0
const JUMP_FORCE := -420.0

# --- VARIABLES ---
var barking := false

@onready var anim := $AnimatedSprite2D

func _ready():
	# Connect the signal for when an animation ends
	if not anim.animation_finished.is_connected(_on_anim_finished):
		anim.animation_finished.connect(_on_anim_finished)

func _physics_process(delta):
	# --- GRAVITY ---
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		if velocity.y > 0:
			velocity.y = 0

	# --- BARKING LOGIC ---
	# This requires the "Bark" action in Project Settings -> Input Map
	if Input.is_action_just_pressed("Bark") and not barking:
		barking = true
		anim.play("Bark")
		velocity.x = 0 

	# --- MOVEMENT ---
	if not barking:
		var dir := Input.get_axis("move_left", "move_right")
		velocity.x = dir * SPEED

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_FORCE

		# --- ANIMATIONS ---
		if dir != 0:
			anim.flip_h = dir < 0
			anim.play("Walk")
		else:
			anim.play("Idle")

	move_and_slide()

# --- SIGNAL CALLBACK ---
func _on_anim_finished():
	if anim.animation == "Bark":
		barking = false
