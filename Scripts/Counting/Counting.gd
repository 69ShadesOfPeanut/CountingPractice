extends Control

const NumberResponse = preload("res://Scenes/Counting/NumberResponse.tscn")

# declare nodes
onready var NumberEnter = get_node("%NumberEnter")
onready var Numbers = get_node("%Numbers")
onready var Scroll = get_node("%Scroll")
onready var Scrollbar = Scroll.get_v_scrollbar()

var CurrentNum = CurrentNumGlobal.CurrentNum
var MaxScrollLength := 0

# on ready, print 1
func _ready():
	Scrollbar.connect("changed", self, "ScrollBarChanged")
	MaxScrollLength = Scrollbar.max_value
	
	Instance("Computer: ", CurrentNum)
	CurrentNum = int(CurrentNum)
	CurrentNum += 1

# when the scroll bar changes, scroll down
func ScrollBarChanged():
	if MaxScrollLength != Scrollbar.max_value:
		MaxScrollLength = Scrollbar.max_value
		Scroll.scroll_vertical = MaxScrollLength

# clear the line and put what the user typed along with the next number on screen
# converts new_text to int var type
func NumberEntered(new_text):
	NumberEnter.clear()
	new_text = int(new_text)
	
	if new_text == CurrentNum:
		print("Right")
		CurrentNum += 1
	else:
		print("Wrong")
		# checks if score is higher than highscore
		# if score is higher than highscore, save highscore as json
		var file = File.new()
		if file.file_exists("user://Highscore"):
			file.open("user://Highscore", file.READ_WRITE)
			var content = JSON.parse(file.get_as_text())
			
			var Highscore = content.result["Highscore"]
			if CurrentNum > Highscore:
				Highscore = {
					"Highscore" : CurrentNum
				}
				file.store_line(to_json(Highscore))
			
			file.close()
			
			get_tree().change_scene("res://Scenes/Menu.tscn")
		else:
			var Highscore = {
				"Highscore" : CurrentNum
			}
			
			file.open("user://Highscore", file.WRITE)
			file.store_line(to_json(Highscore))
			file.close()
			
			get_tree().change_scene("res://Scenes/Menu.tscn")
	
	# displays users number
	new_text = str(new_text)
	Instance("User: ", new_text)
	
	# displays computers number
	CurrentNum = str(CurrentNum)
	Instance("Computer: ", CurrentNum)
	
	# converts back to int and adds 1
	CurrentNum = int(CurrentNum)
	CurrentNum += 1

# function to instance new number
func Instance(User: String, Number: String):
	var NumberResponseInstance = NumberResponse.instance()
	NumberResponseInstance.SetNumber(User, Number)
	Numbers.add_child(NumberResponseInstance)
