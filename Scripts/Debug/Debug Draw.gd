extends CanvasItem

var original_children_states = {}
var lines = []

func _ready():
	DebugUtil.set_debug_canvas_item(self)

func _draw():
	if DebugUtil.is_current(self):
		for line in DebugUtil.lines:
			draw_line(line[0], line[1], line[2], line[3])

func initialize_debug():
	for child in get_children():
		if child is CanvasItem:
			original_children_states[child] = child.show_behind_parent
			child.show_behind_parent = true

func finalize_debug():
	for state in original_children_states:
		var child = state.key
		var show_behind_parent = state.value
		child.show_behind_parent = show_behind_parent
