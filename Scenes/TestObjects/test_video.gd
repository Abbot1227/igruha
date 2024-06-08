extends Control

@onready var video_player: VideoStreamPlayer = $VideoStreamPlayer

func _ready():
	# Set the video stream
	#video_player.stream = 
	#video_player.stream = preload("res://Videos/cat.webm")

	# Connect the finished signal to a function
	#video_player.connect("finished", self, "_on_video_finished")

	# Play the video
	video_player.play()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if video_player.is_playing():
			video_player.stop()
		else:
			video_player.play()

func _on_video_finished():
	print("Video playback finished")
	# Optionally, you can restart the video or perform other actions
	video_player.play()
