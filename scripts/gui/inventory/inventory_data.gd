class_name InventoryData extends Resource

@export var slots : Array[SlotData]



func add_item(item : ItemData, count : int = 1) -> bool:
	for slot in slots:
		if slot:
			if slot.item_data == item:
				slot.quantity += count
				return true
	
	for i in slots.size():
		if slots[i] == null:
			var new_item = SlotData.new()
			new_item.item_data = item
			new_item.quantity = count
			slots[i] = new_item
			return true
	
	print("Inv was full. No Go.")			
	return false
	
	
