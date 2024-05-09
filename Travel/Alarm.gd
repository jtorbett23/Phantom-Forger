extends PopupTurbo

class_name AlarmPopup

var percentage_from_top : float = 20
var alarm_time : float = 5 #change to 30
var remaning_time : float = alarm_time
var seperation : int = 10
var timer_label : Label 
var enabled : bool = true

var alarm_noise_path : String = "res://assets/audio/sound/weewoo.mp3"

var callback : Callable


func _init(message : String = "Test", mode : int = STATIC, close_callback: Callable = Callable()) -> void:
	super(message, mode, close_callback)
	self.set_anchors_preset(PRESET_CENTER_TOP)
	self.callback = close_callback
	timer_label = Label.new()
	timer_label.name = "Timer"
	timer_label.text = str(alarm_time) + " s"
	timer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	timer_label.set_anchors_and_offsets_preset(PRESET_CENTER, PRESET_MODE_KEEP_HEIGHT)
	$"Background/Content Container".add_theme_constant_override("separation", seperation)

	$"Background/Content Container".add_child(timer_label)



func _ready():
	var viewport_height : int = get_viewport().get_size().y
	self.position.y = viewport_height * (percentage_from_top / 100)
	AudioManager.play_sound(alarm_noise_path)

func _process(delta):
	if(enabled):
		if(remaning_time > 0):
			remaning_time -= delta
			var visible_time : String = "%.1f" % [remaning_time] + " s"
			timer_label.text = visible_time

		if remaning_time < 0:
			var visible_time : String = "%.1f" % [0] + " s"
			timer_label.text = visible_time
			if(callback):
				callback.call()
				queue_free()


