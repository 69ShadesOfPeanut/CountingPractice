extends Control

onready var HighscoreText = get_node("%Highscore")

# checks if highscore exists
# if highscore exists, set the highscore text as the highscore
func _ready():
	var file = File.new()
	if file.file_exists("user://Highscore"):
		file.open("user://Highscore", file.READ)
		var content = JSON.parse(file.get_as_text())
		file.close()
		
		var Highscore = str(content.result["Highscore"])
		HighscoreText.set_text("Highscore: " + Highscore)

func OddPressed():
	CurrentNumGlobal.CurrentNum = "0"
	get_tree().change_scene("res://Scenes/Counting/Counting.tscn")

func EvenPressed():
	CurrentNumGlobal.CurrentNum = "1"
	get_tree().change_scene("res://Scenes/Counting/Counting.tscn")
