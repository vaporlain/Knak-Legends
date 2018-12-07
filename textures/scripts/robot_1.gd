extends KinematicBody2D

const MAX_VEL = 50

enum STATES { IDLE, RUN, DEAD, NONE }

var game = self

var state_cur = -1
var state_nxt = STATES.NONE
var dir_cur = 1
export var dir_nxt = 1
var anim_cur = "idle"
var anim_nxt = "idle"
var vel = Vector2()

func _ready():
	$anim.seek( rand_range( 0, 0.2 ) )
#	$statetimer.wait_time = rand_range( 2, 4 )
#	$statetimer.start()


func _physics_process( delta ):
#	if name == "robot_3":
#		print( state_nxt )
	state_cur = state_nxt
	if state_cur == STATES.IDLE:
		_state_idle( delta )
	elif state_cur == STATES.RUN:
		_state_run( delta )
	elif state_cur == STATES.DEAD:
		_state_dead( delta )
	
	if anim_nxt != anim_cur:
		anim_cur = anim_nxt
		$anim.play( anim_cur )
		if anim_cur == "idle":
			$anim.seek( rand_range( 0, 0.2 ) )
	if dir_nxt != dir_cur:
		dir_cur = dir_nxt
		$rotate.scale.x = dir_cur


var _idle_timer = 1
func _state_idle( delta ):
	anim_nxt = "idle"
	_idle_timer -= delta
	if _idle_timer <= 0:
		_idle_timer = 1
		#print( get_name(), ": leaving idle state" )
		state_nxt = STATES.RUN
	

func _state_run( delta ):
	# move until reaching an obstacle or timer expired
	anim_nxt = "run"
	move_and_slide( Vector2( dir_cur, 0 ) * MAX_VEL )
	if on_obstacle():
		return

var _dead_timer = 3
func _state_dead( delta ):
	_dead_timer -= delta
	vel.y += 800 * delta
	move_and_slide( vel )
	anim_nxt = "dead"
	if ( global_position.y - game.camera.global_position.y > 200 ) or _dead_timer <= 0:
		#print( "finished robot" )
		queue_free()

func destroy( pos = null ):
	vel = Vector2( -100, -200 ) * 60 * get_physics_process_delta_time()
	$rotate/hitbox.queue_free()
	$collision.queue_free()
	$statetimer.queue_free()
	$ray1.queue_free()
	$ray2.queue_free()
	$damagebox.queue_free()
	state_nxt = STATES.DEAD
	$AudioStreamPlayer.play()
	#queue_free()

func on_obstacle():
	var coldata = null
	if get_slide_count() > 0:
		coldata = get_slide_collision( 0 )
	if coldata != null or ( dir_cur == 1 and not $ray2.is_colliding() ) or ( dir_cur == -1 and not $ray1.is_colliding() ):
		#if name == "robot_3":
		#	print( "robot 3 collided" )
		state_nxt = STATES.IDLE
#		$statetimer.stop()
#		$statetimer.wait_time = 1
#		$statetimer.start()
		dir_nxt = -dir_cur
		return true
	return false

func _on_statetimer_timeout():
	return
	#if name == "robot_3":
	#		print( "robot 3 back to run" )
	state_nxt = STATES.RUN
#	if state_cur == STATES.IDLE:
#		state_nxt = STATES.RUN
#	elif state_cur == STATES.RUN:
#		state_nxt = STATES.IDLE

func _on_hitbox_area_entered( area ):
	if area.is_in_group( "damagebox" ):
		game.player.destroy( position )
	pass # replace with function body

var _visible = false
func _on_VisibilityNotifier2D_screen_entered():
	if _visible: return
	_visible = true
	state_nxt = STATES.IDLE
