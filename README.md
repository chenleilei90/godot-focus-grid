# Godot Focus Grid

A small, dependency-free GDScript helper for explicit keyboard focus in inventory or menu grids. It works without textures or paid assets.

## Behaviour

- Row-major controls, supplied explicitly by the caller.
- Arrow keys move to the neighbouring cell; at an edge (including a missing cell in the final row), focus stays put.
- Tab and Shift+Tab cycle through every supplied item.
- Invalid column counts, invalid/unparented controls and duplicates return `ERR_INVALID_PARAMETER` before changing any control.
- Empty lists are accepted. One-item grids point all neighbours back to themselves.

## Use in Godot 4

Copy `focus_grid.gd` into your project. Call after the controls enter the scene tree, for example from a parent's `_ready()`:

```gdscript
const GridFocus = preload("res://focus_grid.gd")

func _ready() -> void:
    var cells: Array[Control] = [$Grid/SlotA, $Grid/SlotB, $Grid/SlotC]
    var result = GridFocus.wire(cells, 3)
    if result == OK and not cells.is_empty():
        cells[0].grab_focus()
```

Supply only visible, enabled controls under a common ancestor. Re-run after changing ordering, layout or available cells. The helper does not detect hidden or disabled controls, does not calculate geometry, and does not install input mappings. Godot's usual UI input actions must remain available. It sets `focus_mode` to `FOCUS_ALL` for each item. This is not an accessibility certification.

## Run the tests

From this folder:

```sh
godot --headless --path . --script tests/test_focus.gd
```

Validated with Godot **4.6.3** on Linux using the headless renderer. Tests create actual Button nodes, resolve neighbour paths, and cover incomplete rows, boundaries, Tab cycling, empty/single grids and invalid arguments. Tests verify configuration, not physical keyboard/gamepad input, visual quality or every Godot version. No other OS/device testing is claimed.

## License and AI disclosure

MIT license applies only to the code and documentation in this repository. Code and documentation were produced with AI assistance and checked with the included automated tests. No third-party graphics, paid asset files, credentials or copied artwork are included. No claim of exclusive copyright in AI-generated portions is made.

## Optional visual assets

This utility is independent and free. The publisher also offers [Tidelight UI Starter](https://chenleilei90.itch.io/tidelight-ui-starter), a separate SVG/PNG UI asset pack with a free button sample. It is **not required** here. Its separate asset license is unchanged and does not become MIT because this helper is MIT. There is no affiliation with or endorsement by Godot or GitHub.
