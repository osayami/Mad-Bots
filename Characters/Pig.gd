extends RigidBody2D

var health = 150
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().create_timer(3).timeout
	contact_monitor = true


func _on_body_entered(body: Node) -> void:
	
	if is_instance_valid(body):
		if body is RigidBody2D:
			if body.is_in_group("Player"):
				queue_free()
			else:
				var damage = body.linear_velocity.length() * 0.7
				health -= damage
				GameManager.Score += damage
				if health <=0:
					queue_free()
		
