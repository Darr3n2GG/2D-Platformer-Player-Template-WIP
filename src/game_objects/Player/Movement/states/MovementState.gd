class_name PlayerMovementState extends State


const IDLE = "Idle"
const ACCEL = "Accel"
const DECEL = "Decel"
const TURN = "Turn"
const MAX = "Max"

var player: CharacterBody2D
var input: LRInput


func _ready() -> void:
	await owner.ready
	player = owner as CharacterBody2D
	input = player.lr_input

# Helper functions
func is_turning() -> bool:
	return player.velocity.x != 0.0 and sign(player.velocity.x) != input.get_direction()
