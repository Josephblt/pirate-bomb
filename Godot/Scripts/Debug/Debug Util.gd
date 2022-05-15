extends Node

var original_children_states = {}
var current_debug_draw_node
var lines = []


func add_line(point_a, point_b):
	lines.append([point_a, point_b, Color.red, 1])
	if current_debug_draw_node:
		current_debug_draw_node.update()


func is_current(debug_draw_node):
	return current_debug_draw_node == debug_draw_node


func set_debug_canvas_item(debug_draw_node):
	if current_debug_draw_node:
		current_debug_draw_node.finalize_debug()
	
	if debug_draw_node:
		current_debug_draw_node = debug_draw_node 
		debug_draw_node.initialize_debug()
