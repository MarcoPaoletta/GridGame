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
	
			
func move(dir):
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
		return true
	return false


	
