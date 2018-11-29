# StartMenu.gd 
extends Control

# ALL THE USER INTERFACE'S ARE UNDER A CONTROL NODE 
# Control was renamed to start menu 
# CenterContainer will take all you give it and put it in the center 
# VBoxContainer will seprated the different labels and buttons up and down 
# all labels and buttons will resize based on the largest child 


# to get the signal below go to StartGameButton -> Node (near Inspector at top) -> pressed()  ->
#  -> connect it to "StartMenu" -> \/ 
func _on_StartGameButton_pressed():
	#print("Hi") # can see down in below it says 'Hi' in Output:  
	get_tree().change_scene("res://World.tscn") # this connects us to the first world 

# To change from start in world.tscn to this  Project -> Application -> Run -> Main Scene => File to set new Start 


func _on_QuitGameButton_pressed():
	get_tree().quit()
