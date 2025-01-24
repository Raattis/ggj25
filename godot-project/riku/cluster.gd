class_name Cluster
extends RigidBody2D

var impulse_cooldown := 0.0

func _process(delta: float):
	impulse_cooldown -= delta
	if global_position.length() > 10000:
		queue_free()

func _integrate_forces(state: PhysicsDirectBodyState2D):
	if impulse_cooldown < 0.0 and state.get_contact_count() > 0:
		var contact_point := state.get_contact_collider_position(0)
		var collider := state.get_contact_collider_object(0)
		var pos := state.get_contact_collider_position(0)
		if get_child_count() == 0:
			queue_free()
			return
		var closest :CollisionShape2D= null
		var closest_dist :float= INF
		var closest_pos := Vector2(0,0)
		for child in get_children() as Array[Node2D]:
			var dist := (child.global_position - pos).length_squared()
			if dist < closest_dist:
				closest = child
				closest_dist = dist
				closest_pos = child.global_position
		closest.queue_free() # TODO: Pop effect
		apply_impulse((pos - closest_pos).normalized() * -300.0, pos)
		impulse_cooldown = 0.1

func destroy():
	for child in get_children() as Array[Node2D]:
		child.queue_free() # TODO: Pop effect
	queue_free()

func _on_body_entered(body: Node2D):
	if (body as StaticBody2D).collision_layer & (1<<3) != 0:
		destroy()
	if (body as StaticBody2D).collision_layer & (1<<4) != 0:
		print("you win!")

func find_closest_spot(pos: Vector2) -> Vector2:
	var closest_dist :float= INF
	var closest_pos := Vector2(0,0)
	for child in get_children() as Array[CollisionShape2D]:
		var diff := (child.global_position - pos)
		var dist := diff.length_squared()
		if dist < closest_dist:
			closest_dist = dist
			closest_pos = child.global_position - diff.normalized() * (child.shape as CircleShape2D).radius * 2
	return closest_pos
