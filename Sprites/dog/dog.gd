extends CharacterBody2D

const SPEED := 220.0
const GRAVITY := 1000.0
const JUMP_FORCE := -420.0
const FALL_LIMIT := 668.0

var barking := false
var saved_pos: Vector2 = Vector2.ZERO
var is_dead := false

@export var max_life: int = 3
@export var trap_damage: int = 1
@export var knockback_force := 600.0

var current_life: int = 3

@onready var anim := $AnimatedSprite2D
@onready var damage_area := $DamageArea

var heart_bar: Node = null

func _ready():
	add_to_group("player")

	heart_bar = get_tree().current_scene.get_node_or_null("HeartBar")

	# Ajusta vida al empezar
	current_life = clamp(current_life, 0, max_life)
	_update_hearts()

	if saved_pos != Vector2.ZERO:
		global_position = saved_pos

	if not anim.animation_finished.is_connected(_on_anim_finished):
		anim.animation_finished.connect(_on_anim_finished)

func save_position():
	saved_pos = global_position

func restore_position():
	if saved_pos != Vector2.ZERO:
		global_position = saved_pos

	current_life = max_life
	is_dead = false
	visible = true
	set_physics_process(true)
	damage_area.set_deferred("monitoring", true)
	_update_hearts()

func _physics_process(delta):
	if is_dead:
		return

	if position.y > FALL_LIMIT:
		die_by_fall()
		return

	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		if velocity.y > 0:
			velocity.y = 0

	check_stomp_enemies()

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

func check_stomp_enemies():
	if velocity.y <= 0:
		return

	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(
		global_position,
		global_position + Vector2(0, 20)
	)
	query.collide_with_areas = true
	query.collide_with_bodies = false

	var result = space_state.intersect_ray(query)

	if result:
		var collider = result.collider
		if collider is Area2D:
			var enemy = collider.get_parent()
			if enemy and enemy.is_in_group("enemy") and enemy.has_method("die_by_stomp"):
				enemy.die_by_stomp()
				velocity.y = JUMP_FORCE * 0.7

func _on_anim_finished():
	if anim.animation == "Bark":
		barking = false

func _on_damage_area_entered(area: Area2D):
	if is_dead:
		return

	if area.is_in_group("spikes") or area.is_in_group("fire"):
		take_damage(trap_damage)
		return

	var enemy = area.get_parent()
	if enemy and enemy.is_in_group("enemy"):
		var dmg := 1
		if "damage" in enemy:
			dmg = enemy.damage
		take_damage(dmg)

func take_damage(amount: int):
	if is_dead:
		return

	current_life -= amount
	current_life = max(current_life, 0)

	if current_life <= 0:
		die()
	else:
		play_damage_effect()
		_update_hearts()

func _update_hearts():
	if heart_bar and heart_bar.has_method("update_lives"):
		heart_bar.call("update_lives", current_life)

func play_damage_effect():
	var tween = create_tween()
	anim.modulate = Color.RED
	tween.tween_property(anim, "modulate", Color.WHITE, 0.15)

func apply_knockback_from_hit(hit_pos: Vector2) -> void:
	var dir := (global_position - hit_pos).normalized()
	if abs(dir.x) < 0.4:
		dir.x = sign(dir.x) if dir.x != 0 else 1
	dir = dir.normalized()
	velocity = dir * knockback_force
	velocity.y = -abs(velocity.y)

func die():
	if is_dead:
		return

	is_dead = true
	_update_hearts()

	get_tree().call_group("game_manager", "show_loser")

	visible = false
	set_physics_process(false)
	damage_area.set_deferred("monitoring", false)

func die_by_fall():
	if is_dead:
		return

	is_dead = true
	_update_hearts()

	get_tree().call_group("game_manager", "show_loser")

	visible = false
	set_physics_process(false)
	damage_area.set_deferred("monitoring", false)
