extends Area2D

@export var steps : Array[Step]
var parent : Node2D
var current_step : int = 0
signal enable
signal print

func _ready():
	parent = get_parent()

	#registers with the event and its signal
	for step in steps:
		var event : Event = step.event
		parent.register_event(event)
		if step.is_emitter: event.emitter = self
		if step.is_target: event.target = self
		if event.event_name == "enable":
			event.emitting_signal = enable
		if event.event_name == "print":
			event.emitting_signal = print
			event.target = parent

	#Discard this
	parent.register_target(self)

func trigger_event():
	if(current_step < steps.size()):
		for step_number in steps.size():
			if steps[step_number].event.triggered:
				current_step = step_number + 1
		steps[current_step].event.trigger()
		current_step += 1

func _on_body_entered(_body):
	trigger_event()

func _on_enable():
	$CollisionShape2D.set_deferred("disabled", false)

func _on_print():
	print("calling print on triggerer: ", name)
