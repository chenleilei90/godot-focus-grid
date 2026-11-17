# Godot Focus Grid：背包与菜单网格的键盘焦点

[English](README.md) · 简体中文

一个免费的 GDScript 小工具，为按行排列的按钮或物品格子设置明确的键盘焦点邻居。无需纹理、付费素材或额外依赖。

## 适合什么情况

在 Godot 4 的背包、选关或菜单网格中，你已经知道每个控件的顺序，想让方向键沿格子移动，而 Tab / Shift+Tab 按列表顺序循环。

- 方向键走到边缘时停留在当前格子，不跨行绕回。
- 最后一行不足一整行时，不跳向不存在的格子。
- 空列表可传入；只有一个格子时，焦点邻居指向自己。
- 列数小于 1、控件无效/未进入场景树或重复传入，会返回 ERR_INVALID_PARAMETER，且不先改动部分控件。

## 最小接入

把 [focus_grid.gd](focus_grid.gd) 复制到项目根目录。在控件进入场景树后调用，例如父节点的 _ready()：

```gdscript
const GridFocus = preload("res://focus_grid.gd")

func _ready() -> void:
    var cells: Array[Control] = [$Grid/SlotA, $Grid/SlotB, $Grid/SlotC]
    var result = GridFocus.wire(cells, 3)
    if result == OK and not cells.is_empty():
        cells[0].grab_focus()
```

将示例节点路径替换为自己的节点。数组按从左到右、从上到下排列；第二个参数是每行列数。

只传入可见、可用、已挂在共同祖先节点下的控件。这个条件由调用方保证：工具不会自动过滤隐藏或禁用项，也不会检查共同祖先条件。

## 使用边界

- 改变格子顺序、布局或可用项后，需要重新调用。
- 工具会把每个控件的 focus_mode 设置为 FOCUS_ALL。
- 不计算屏幕几何位置，不安装输入映射；需保留 Godot 的常规 UI 输入动作。
- 不提供背包数据、物品使用逻辑、鼠标拖放或完整 UI 框架。
- 这不是无障碍认证；未承诺手柄、实体键盘或其他设备体验。

## 已有验证

仓库原有记录为 Linux / Godot 4.6.3 无界面测试，涵盖真实 Button 节点的邻居路径、边界、不完整行、Tab 循环、空/单项和非法参数。它验证的是配置，不等于实体按键、视觉或跨平台测试。本次新增中文说明，没有重新运行 Godot。

在仓库根目录运行已有测试：

```sh
godot --headless --path . --script tests/test_focus.gd
```

## 许可与 AI 说明

本仓库代码和文档使用 MIT 许可。代码及文档由 AI 辅助制作；没有包含付费素材、第三方图形或凭据，不承诺 AI 生成部分具有独占版权。以仓库 LICENSE 为准。

## 可选视觉素材

工具本身免费且独立。作者另有 [Tidelight UI Starter](https://chenleilei90.itch.io/tidelight-ui-starter)，提供 SVG/PNG UI 素材及免费按钮样本，**使用本工具不需要购买**。素材包适用其自身许可，不因本工具使用 MIT 而变成 MIT。与 Godot 或 GitHub 无官方关联或背书。
