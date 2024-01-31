extends Camera2D

var startingPos
var player
var followingPlayer
var clicking
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startingPos = global_position
	player = get_tree().get_first_node_in_group("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if followingPlayer:
		if is_instance_valid(player):
			if player.position.x > position.x:
				var playerPos = clamp(player.position.x ,0 , 5000)
				global_position = Vector2(playerPos, startingPos.y)
				
		else:
			followingPlayer = false
			var tween = get_tree().create_tween()
			tween.tween_property(self , "position" , startingPos ,2)
			tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
			
	if Input.is_action_just_pressed("Left_mouse"):
		clicking = true
	elif Input.is_action_just_released("Left_mouse"):
		clicking = false
			
func _input(event: InputEvent) -> void:
	var slingShot = get_tree().get_first_node_in_group("Slingshot")
	if not slingShot.currentState == slingShot.SlingState.pulling:
		if event is InputEventScreenDrag:
			move_local_x(event.relative.x * -1)
			move_local_y(event.relative.y * -1)
		if clicking:
			if event is InputEventMouseMotion:
				move_local_x(event.relative.x * -1)
				move_local_y(event.relative.y * -1)
		
		