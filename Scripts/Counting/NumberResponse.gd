extends VBoxContainer

# set text of Number to the number submitted
# converts int back to string so it can be displayed
func SetNumber(user: String, number: String):
	$Number.set_text(user + number)
