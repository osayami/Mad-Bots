extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func SetScore():
	$HUD/ScoreValue.text= str(int(GameManager.Score))

func PopupLevelCompleted(win:bool , score):
	$Popup/ScoreValue.text = str(int(GameManager.Score))
	$HUD.visible = false
	if win:
		#$Popup/WonOrLose.text = "You Won!"
		var tween = get_tree().create_tween()
		if score > 20:
			$Popup/Star1.visible=true
			tween.tween_property(
					$Popup/Star1 , "scale",Vector2(.23,.19) ,0.5) \
					.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		if score > 50:
			$Popup/Star2.visible=true
			tween.tween_property(
					$Popup/Star2 , "scale",Vector2(.23,.19) ,0.5) \
					.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		if score > 100:
			$Popup/Star3.visible=true
			tween.tween_property(
					$Popup/Star3 , "scale",Vector2(.23,.19) ,0.5) \
					.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

		$Popup/ScoreValue.text = str(int(GameManager.Score))
	else:
		#$Popup/WonOrLose.text = "You lost!"
		$Popup/NextLevelButton.disabled = true
		$Popup/ScoreLabel.visible = false 
		$Popup/ScoreValue.visible = false
		
	$Popup.visible = true


func _on_next_level_button_button_down() -> void:
	GameManager.LoadNextLevel()


func _on_restart_button_button_down() -> void:
	GameManager.RestartLevel()
