extends Node2D

@onready var left_line: Line2D = $LeftLine
@onready var right_line: Line2D = $RightLine

var CenterOfSlingshot

enum SlingState{
	idle,
	pulling,
	birdThrown,
	reset
}
var currentState

var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentState = SlingState.idle
	CenterOfSlingshot = $CenterOfSlingshot.position
	left_line.points[0] = CenterOfSlingshot
	right_line.points[0] = CenterOfSlingshot
	player = get_tree().get_first_node_in_group("Player") as RigidBody2D
	player.position = CenterOfSlingshot
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match currentState:
		SlingState.idle:
			pass
			
		SlingState.pulling:
			#var player = get_tree().get_first_node_in_group("Player") as RigidBody2D
			
			if Input.is_action_pressed("Left_mouse"):
				var distance = get_global_mouse_position()
				
				if distance.distance_to(CenterOfSlingshot) > 300:
					distance = (distance - CenterOfSlingshot ).normalized() * 300 + CenterOfSlingshot
				player.position = distance
				left_line.points[0] = distance
				right_line.points[0] = distance
			else:
				var location = get_global_mouse_position()
				var distance = location.distance_to(CenterOfSlingshot)
				var velocity = CenterOfSlingshot - location
				player.ThrowBird()
				player.apply_impulse(velocity/150 * distance,Vector2())
				currentState = SlingState.birdThrown
				left_line.points[0] = CenterOfSlingshot
				right_line.points[0] = CenterOfSlingshot
				GameManager.CurrentGameState = GameManager.GameState.Play
				get_tree().get_first_node_in_group("Camera").followingPlayer = true
		SlingState.birdThrown:
			pass
			
		SlingState.reset:
			var lives = get_tree().get_nodes_in_group("Player")
			if lives.size() > 0:
				player =  lives[0] as RigidBody2D
				get_tree().create_tween().tween_property(
					player , "position",CenterOfSlingshot ,0.5
					).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
				if (player.global_position - CenterOfSlingshot).length() <= .1:
					currentState = SlingState.idle


func _on_touch_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if currentState == SlingState.idle:
		if event is InputEventMouseButton && event.is_pressed():
			currentState = SlingState.pulling
