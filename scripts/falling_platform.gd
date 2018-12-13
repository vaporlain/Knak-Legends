tool
extends KinematicBody2D

var motion = Vector2()
var timer
var counter
export var sleepTime = 1
export var fallTime = 1
var alpha = 1

func _ready():
	
	timer = Timer.new()
	timer.connect("timeout", self, "start")
	timer.wait_time = sleepTime
	add_child(timer)
	
	counter = Timer.new()
	counter.connect("timeout", self, "stop")
	timer.wait_time = fallTime
	add_child(counter)

func _process(delta):
	
	pass
	
func _physics_process(delta):
	motion = move_and_slide(motion)
	if motion.y > 0:
		alpha = alpha - 0.05
		modulate = Color(1, 1, 1, alpha)

func _on_hitbox_body_entered(body):
	if body.name == "player":
		timer.start()

func start():
	print("start")
	timer.stop()
	counter.start()
	$PlatformCol.disabled = true
	
	motion.y = 200
	
func stop():
	print("stop")
	alpha = 1
	modulate = Color(1,1,1,alpha)
	$PlatformCol.disabled = false
	motion.y = 0
	self.position = Vector2(0, 0)
	counter.stop()
	
