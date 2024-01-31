extends Node2D

enum GameState{
	Start,
	Play ,
	Win ,
	Lose
}
var CurrentGameState = GameState.Start
var Score = 0
var Levels = ["res://MainScene.tscn","res://level2.tscn"]
var LevelIndex = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Score != 0:
		get_tree().get_first_node_in_group("InterfaceController").SetScore()
	
	match CurrentGameState:
		GameState.Start:
			pass
		GameState.Play:
			var birds = get_tree().get_nodes_in_group("Bird")
			var pigs = get_tree().get_nodes_in_group("Pigs")
			if pigs.size() <= 0:
				CurrentGameState = GameState.Win
			elif birds.size() <= 0:
				CurrentGameState = GameState.Lose
		GameState.Win:
			print("You Win")
			get_tree().get_first_node_in_group("InterfaceController").PopupLevelCompleted(true , Score)
		GameState.Lose:
			print("You Lost")
			get_tree().get_first_node_in_group("InterfaceController").PopupLevelCompleted(false,Score)
	pass

func RestartLevel():
	get_tree().change_scene_to_file(Levels[LevelIndex])
	resetGameManager()

func LoadNextLevel():
	LevelIndex += 1
	if LevelIndex > Levels.size() - 1:
		LevelIndex = 0
	get_tree().change_scene_to_file(Levels[LevelIndex])
	resetGameManager()
	
func resetGameManager():
	CurrentGameState = GameState.Start	
	Score = 0
