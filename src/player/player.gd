extends KinematicBody2D
var grid_size = 16

func _ready():
	OS.center_window()
	
var inputs = {
	"up": Vector2.UP,
	"down": Vector2.DOWN,
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT
}
	


func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			if $Tween.is_active() == false:
				move(dir)
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
			
func move(dir):
	var main = get_parent()
	var vector_pos = inputs[dir] * grid_size
	$RayCast2D.cast_to = vector_pos
	$RayCast2D.force_raycast_update()
	$Tween.interpolate_property(
		self, "position", position, position + vector_pos, 0.1,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
	)
	if !$RayCast2D.is_colliding():
		$Tween.start()
		main.moves += 1
	else:
		var collider = $RayCast2D.get_collider()
		if collider.is_in_group("box"):
			if collider.move(dir):
				$Tween.start()
				main.moves += 1

func _on_Tween_tween_all_completed():
	get_parent().check_end()
