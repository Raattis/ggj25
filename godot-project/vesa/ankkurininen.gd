extends Area2D

var bounce := 1.0
var orig_scale := Vector2(0,0)

func _ready():
	orig_scale = scale

func _process(delta: float) -> void:
	scale = orig_scale * lerp(scale.y / orig_scale.y, bounce, 0.1)
	bounce = clamp(bounce - delta * 1.0, 1.0, 100.0)

func _on_body_entered(body: Node2D) -> void:
	var cluster := (body as Cluster)
	cluster.gravity_scale = 1;
	cluster.anchors_collected += 1
	bounce = 2.0
