extends EditorContextMenuPlugin
#{
	#"type": "plugin",
	#"codeRepository": "https://github.com/CodeNameTwister",
	#"description": "HideFolders addon for godot 4",
	#"license": "https://spdx.org/licenses/MIT",
	#"name": "Twister",
	#"version": "1.0.2"
#}
#region godotengine_repository_icons
const HIDE_ICON : Texture = preload("res://addons/Hidefolders/images/GuiVisibilityHidden.svg")
const VISIBLE_ICON : Texture = preload("res://addons/Hidefolders/images/GuiVisibilityVisible.svg")
const TOGGLE_ICON : Texture = preload("res://addons/Hidefolders/images/GuiVisibilityXray.svg")
#endregion

signal hide_folders(path)

var ref_plug : EditorPlugin = null

func _popup_menu(paths: PackedStringArray) -> void:
	var _process : bool = false
	var is_hided : bool = false
	var is_visible : bool = false

	var _ref : Dictionary = {}
	if is_instance_valid(ref_plug):
		_ref = ref_plug.get_buffer()

	for p : String in paths:
		if !FileAccess.file_exists(p) and DirAccess.dir_exists_absolute(p):
			_process = true
			if _ref.has(p):
				is_hided = true
			else:
				is_visible = true

	if _process:
		if is_visible and is_hided:
			add_context_menu_item("{0} {1}".format([tr("toggle"),tr("folder")]), _on_hide_cmd, TOGGLE_ICON)
		elif is_visible:
			add_context_menu_item("{0} {1}".format([tr("hide"),tr("folder")]), _on_hide_cmd, VISIBLE_ICON)
		else:
			add_context_menu_item("{0} {1}".format([tr("show"),tr("folder")]), _on_hide_cmd, HIDE_ICON)

func _on_hide_cmd(paths : PackedStringArray) -> void:
	hide_folders.emit(paths)
