extends Node2D

var events : Array[Event]
var targets : Array[Node]
var triggerers : Array[Node]

func register_target(node : Node):
	targets.append(node)

func register_triggerer(node : Node):
	triggerers.append(node)

func register_event(event : Event):
	events.append(event)

func _on_print():
	print("calling print on level")
