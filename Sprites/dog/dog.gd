extends CharacterBody2D

const SPEED := 220.0
const GRAVITY := 1000.0
const JUMP_FORCE := -420.0

var barking := false
var saved_pos: Vector2 = Vector2.ZERO 

@export var knockback_force := 600.0

@onready var anim := $AnimatedSprite2D

func _ready():
	if saved_pos != Vector2.ZERO:
		global_position = saved_pos
	else:
		pass
	
	if not anim.animation_finished.is_connected(_on_anim_finished):
		anim.animation_finished.connect(_on_anim_finished)

func save_position(): 
	saved_pos = global_position 

func restore_position(): 
	if saved_pos != Vector2.ZERO:
		global_position = saved_pos

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		if velocity.y > 0:
			velocity.y = 0

	var dir := Input.get_axis("move_left", "move_right")

	if barking and (dir != 0 or Input.is_action_just_pressed("jump")):
		barking = false

	if Input.is_action_just_pressed("bark") and not barking:
		barking = true
		anim.play("Bark")
		velocity.x = 0

	if not barking:
		velocity.x = dir * SPEED

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_FORCE

		if not is_on_floor():
			anim.play("jump")
		elif dir != 0:
			anim.flip_h = dir < 0
			anim.play("Walk")
		else:
			anim.play("Idle")
	else:
		anim.play("Bark")

	move_and_slide()

func _on_anim_finished():
	if anim.animation == "Bark":
		barking = false

func apply_knockback_from_hit(hit_pos: Vector2) -> void:
	var dir := (global_position - hit_pos).normalized()

	if abs(dir.x) < 0.4:
		dir.x = sign(dir.x) if dir.x != 0 else 1

	dir = dir.normalized()
	velocity = dir * knockback_force

	velocity.y = -abs(velocity.y)
