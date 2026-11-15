extends SceneTree
const Grid = preload("res://focus_grid.gd")
func _initialize() -> void:
	call_deferred("run_tests")
func run_tests() -> void:
	var host = Control.new()
	root.add_child(host)
	var buttons: Array[Control] = []
	for i in range(5):
		var button = Button.new()
		button.name = "Button%d" % i
		host.add_child(button)
		buttons.append(button)
	assert(Grid.wire(buttons, 3) == OK)
	assert(buttons[0].get_node(buttons[0].focus_neighbor_right) == buttons[1])
	assert(buttons[2].get_node(buttons[2].focus_neighbor_right) == buttons[2])
	assert(buttons[2].get_node(buttons[2].focus_neighbor_bottom) == buttons[2])
	assert(buttons[1].get_node(buttons[1].focus_neighbor_bottom) == buttons[4])
	assert(buttons[3].get_node(buttons[3].focus_neighbor_top) == buttons[0])
	assert(buttons[4].get_node(buttons[4].focus_next) == buttons[0])
	assert(buttons[0].get_node(buttons[0].focus_previous) == buttons[4])
	assert(Grid.wire(buttons, 0) == ERR_INVALID_PARAMETER)
	assert(Grid.wire([], 2) == OK)
	var one: Array[Control] = [buttons[0]]
	assert(Grid.wire(one, 1) == OK)
	assert(buttons[0].get_node(buttons[0].focus_neighbor_left) == buttons[0])
	assert(Grid.wire([buttons[0], buttons[0]], 2) == ERR_INVALID_PARAMETER)
	var prior = buttons[0].focus_neighbor_right
	assert(Grid.wire([buttons[0], null], 2) == ERR_INVALID_PARAMETER)
	assert(buttons[0].focus_neighbor_right == prior)
	var detached = Control.new()
	assert(Grid.wire([detached], 1) == ERR_INVALID_PARAMETER)
	detached.free()
	print("PASS: grid neighbours, incomplete row, tab cycle, empty/single, invalid columns/duplicates")
	quit(0)
