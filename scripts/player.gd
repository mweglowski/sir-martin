extends CharacterBody2D

const SPEED = 100.0
const BASE_JUMP_VELOCITY = -100.0  # Minimum jump height (tap space)
const MAX_JUMP_VELOCITY = -400.0   # Maximum jump height (full charge)
const MAX_HORIZONTAL_JUMP = 250.0  # How fast you move sideways when jumping

var is_charging := false
var jump_charge := 0.0       # Tracks from 0.0 (empty) to 1.0 (full)
var jump_charge_rate := 1.5  # How fast it charges (1.0 / seconds to full charge)
var friction = 450

@export var pause_screen: PackedScene
@onready var animated_sprite = $AnimatedSprite2D
@onready var tile_map: TileMap = $"../TileMap"
@onready var dust_particles = $GPUParticles2D

var last_ground_type := "normal"
var was_in_air = false

func create_dust():
	dust_particles.restart()
	dust_particles.emitting = true

func _physics_process(delta: float) -> void:
	if is_on_floor() and was_in_air:
		create_dust()
		was_in_air = false
	
	if not is_on_floor():
		was_in_air = true
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("move_left", "move_right")

	if direction != 0:
		animated_sprite.flip_h = direction < 0

	if is_on_floor():
		# --- 1. MULTI-POINT TILE DETECTION ---
		# Check slightly left and right of center (adjust 4.0 based on sprite width)
		var check_offsets = [-6.0, 0.0, 6.0] 
		var current_tile_type = "air_edge"
		
		for offset in check_offsets:
			var foot_pos = global_position + Vector2(offset, 2)
			var map_pos = tile_map.local_to_map(tile_map.to_local(foot_pos))
			var tile_data = tile_map.get_cell_tile_data(1, map_pos)
			
			if tile_data:
				var type = tile_data.get_custom_data("type")
				# Priority: If any part of us touches 'slippery', the whole state is slippery
				if type == "slippery":
					current_tile_type = "slippery"
					break 
				else:
					current_tile_type = type

		# If we are strictly on the edge (no tile found), we inherit the last known type
		# This prevents "sticking" when walking off ledges.
		var active_logic = current_tile_type
		if active_logic == "air_edge":
			active_logic = last_ground_type
		else:
			last_ground_type = current_tile_type

		# --- 2. HANDLE JUMP CHARGING ---
		if Input.is_action_pressed("jump"):
			is_charging = true
			jump_charge = clamp(jump_charge + (delta * jump_charge_rate), 0.0, 1.0)
			
			if active_logic == "slippery":
				velocity.x = move_toward(velocity.x, 0, friction * delta)
			else:
				velocity.x = 0
			
			animated_sprite.play("idle") 
			
		elif Input.is_action_just_released("jump") and is_charging:
			is_charging = false
			velocity.y = lerp(BASE_JUMP_VELOCITY, MAX_JUMP_VELOCITY, jump_charge)
			velocity.x = direction * MAX_HORIZONTAL_JUMP * jump_charge
			jump_charge = 0.0
			animated_sprite.play("jump")
			
		else:
			# --- 3. NORMAL WALKING / SLIDING ---
			is_charging = false
			jump_charge = 0.0
			
			if active_logic == 'slippery':
				var target_vel = direction * SPEED if direction and active_logic != 'jump_only' else 0.0
				velocity.x = move_toward(velocity.x, target_vel, friction * delta)
				
				if direction != 0: animated_sprite.play("run")
				else: animated_sprite.play("idle")
			else:
				if direction and active_logic != 'jump_only':
					velocity.x = direction * SPEED
					animated_sprite.play("run")
				else:
					velocity.x = 0
					animated_sprite.play("idle")
	else:
		is_charging = false
		# While in the air, we reset last_ground_type to normal 
		# so you don't "slide" mid-air when landing on a new platform.
		last_ground_type = "normal"

	#if Input.is_action_just_released("jump") and is_on_floor():
		#create_dust()

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if not get_tree().paused:
			pause_game()

func pause_game():
	var pause_menu = pause_screen.instantiate()
	add_child(pause_menu)
	get_tree().paused = true
