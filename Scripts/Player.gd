extends CharacterBody3D

@onready var head: Node3D = $Head
@onready var eyes: Node3D = $Head/Eyes
@onready var camera_3d: Camera3D = $Head/Eyes/Camera3D
@onready var standing_collision_shape: CollisionShape3D = $StandingCollisionShape
@onready var crouch_collision_shape: CollisionShape3D = $CrouchCollisionShape
@onready var stand_up_check: RayCast3D = $Head/StandUpCheck

const WALK_SPEED: float = 3.0
const SPRINT_SPEED: float = 5.0
const CROUCH_SPEED: float = 1.0
const CROUCHING_DEPTH: float = -0.65
const JUMP_SPEED: float = 4.0

var current_speed: float = 0.0
var moving: bool = false
var input_dir: Vector2 = Vector2.ZERO
var direction: Vector3 = Vector3.ZERO
var mouse_sensitivity: float = 0.2

# State Machine
enum PlayerState
{
	IDLE_STAND,
	IDLE_CROUCH,
	CROUCHING,
	WALKING,
	SPRINTING,
	AIR
}

var player_state: PlayerState = PlayerState.IDLE_STAND

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-85), deg_to_rad(85))

func _physics_process(delta: float) -> void:
	return
