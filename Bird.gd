extends RigidBody2D

enum BirdState{
	notThrown,
	thrown
}
var currentState
func _ready() -> void:
	freeze = true
	currentState = BirdState.notThrown
	
func _process(delta: float) -> void:
	if currentState == BirdState.thrown && linear_velocity <= Vector2(2,2):
		await get_tree().create_timer(2).timeout
		var slingShot = get_tree().get_first_node_in_group("Slingshot")
		slingShot.currentState = slingShot.SlingState.reset
		queue_free()
	
func ThrowBird():
	freeze = false
	currentState = BirdState.thrown
