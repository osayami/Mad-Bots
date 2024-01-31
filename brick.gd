extends RigidBody2D

var health = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(3).timeout
	contact_monitor = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if is_instance_valid(body):
		if body is RigidBody2D:
			body = body as RigidBody2D
			var damage = body.linear_velocity.length() * 0.1
			health -= damage
			if health <= 0:
				queue_free()
