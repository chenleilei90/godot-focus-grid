class_name FocusGrid
extends RefCounted
## Explicit keyboard neighbours for a row-major list of Controls.
## Edges stay on the current item; Tab/Shift+Tab cycle across all items.
## Pass only visible/enabled items, already parented under a common ancestor.
static func wire(items: Array[Control], columns: int) -> Error:
	if columns < 1:
		return ERR_INVALID_PARAMETER
	var seen := {}
	for item in items:
		if not is_instance_valid(item) or not item.is_inside_tree() or seen.has(item):
			return ERR_INVALID_PARAMETER
		seen[item] = true
	var count := items.size()
	for i in range(count):
		var item := items[i]
		item.focus_mode = Control.FOCUS_ALL
		var left := i - 1 if i % columns > 0 else i
		var right := i + 1 if i % columns < columns - 1 and i + 1 < count else i
		var up := i - columns if i >= columns else i
		var down := i + columns if i + columns < count else i
		item.focus_neighbor_left = item.get_path_to(items[left])
		item.focus_neighbor_right = item.get_path_to(items[right])
		item.focus_neighbor_top = item.get_path_to(items[up])
		item.focus_neighbor_bottom = item.get_path_to(items[down])
		item.focus_next = item.get_path_to(items[(i + 1) % count])
		item.focus_previous = item.get_path_to(items[(i + count - 1) % count])
	return OK
