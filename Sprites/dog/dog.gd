extends CharacterBody2D

const SPEED := 220.0
const GRAVITY := 1000.0
const JUMP_FORCE := -420.0
const FALL_LIMIT := 668.0

var barking := false
var saved_pos: Vector2 = Vector2.ZERO

@export var max_life: int = 3
@export var trap_damage: int = 1
@export var knockback_force := 600.0

var current_life: int = 3

@onready var anim := $AnimatedSprite2D
@onready var damage_area = $DamageArea

func _ready():
	if saved_pos != Vector2.ZERO:
		global_position = saved_pos
	
	if not anim.animation_finished.is_connected(_on_anim_finished):
		anim.animation_finished.connect(_on_anim_finished)

func save_position(): 
	saved_pos = global_position

func restore_position(): 
	if saved_pos != Vector2.ZERO:
		global_position = saved_pos

func _physics_process(delta):
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
	if area.is_in_group("spikes") or area.is_in_group("fire"):
		take_damage_from_traps()
		return
	
	var enemy = area.get_parent()
	if enemy and enemy.is_in_group("enemy"):
		take_damage_from_enemy(enemy)

func take_damage_from_enemy(enemy: Node2D):
	var damage = 1
	if "damage" in enemy:
		damage = enemy.damage
	
	current_life -= damage
	current_life = max(current_life, 0)
	
	if current_life <= 0:
		die()
	else:
		play_damage_effect()

func take_damage_from_traps():
	current_life -= trap_damage
	current_life = max(current_life, 0)
	
	if current_life <= 0:
		die()
	else:
		play_damage_effect()

func play_damage_effect():
	pass

func apply_knockback_from_hit(hit_pos: Vector2) -> void:
	var dir := (global_position - hit_pos).normalized()
	if abs(dir.x) < 0.4:
		dir.x = sign(dir.x) if dir.x != 0 else 1
	dir = dir.normalized()
	velocity = dir * knockback_force
	velocity.y = -abs(velocity.y)

func die():
	queue_free()

func die_by_fall():
	queue_free()
