class_name BoozeData extends Resource

# General Stats
@export var name: String
@export var abv: float       # Alcohol by Volume (percentage)
@export var color: String     # Display color (e.g., for cocktails or visuals)
@export var flavor_profile: String  # Description of the flavor (e.g., "Sweet", "Herbal")
@export var origin: String   # Region or country of origin
@export var rarity: int      # Common (1), Uncommon (2), Rare (3), Legendary (4)
@export var price: int       # Base price in in-game currency
@export var special_effect: String = ""  # Any unique bonus or effect

# Visual/Gameplay Effects
@export var texture: Texture2D  # Icon to represent the booze in menus
@export_multiline var description : String
