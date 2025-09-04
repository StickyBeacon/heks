extends Node


func select_hex(pos : Vector2, unselect : bool = false):
	if unselect:
		%HexInfo.visible = false
		return
	%HexInfo.visible = true	
	%HexPos.text = "<%s,%s>" % [int(pos.x),int(pos.y)]
