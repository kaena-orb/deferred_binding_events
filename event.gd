extends Resource
class_name Event

@export var event_name : String
@export var triggered : bool = false

var emitter : Node :
	set(new_node):
		emitter = new_node
		wire_signals()

var target : Node :
	set(new_node):
		target = new_node
		wire_signals()



var emitting_signal : Signal:
	set(new_signal):
		if emitting_signal.is_null():
			emitting_signal = new_signal

func wire_signals():
	if emitting_signal.is_null():
		return
	match emitting_signal.get_name():
		"print":
			if not emitting_signal.is_connected(target._on_print):
				emitting_signal.connect(target._on_print)
		"enable":
			if not emitting_signal.is_connected(target._on_enable):
				emitting_signal.connect(target._on_enable)

func trigger():
	triggered = true
	wire_signals()
	emitting_signal.emit()
