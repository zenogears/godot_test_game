extends KinematicBody

var speed = 600
var direction = Vector3()
var gravity = -9.8
var velocity = Vector3()
var jump = 10

func _ready():
	pass

func _physics_process(delta):
	direction = Vector3(0,0,0)
	if Input.is_action_pressed("ui_left"):
		direction.x += 1
	if Input.is_action_pressed("ui_right"):
		direction.x -= 1
	if Input.is_action_pressed("ui_up"):
		direction.z += 1
	if Input.is_action_pressed("ui_down"):
		direction.z -= 1
	direction = direction.normalized() * speed * delta
	
	if direction.y > 0:
		gravity = -20
	else:
		gravity = -30
	
	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y = jump

	var hitCount = get_slide_count()
	if hitCount > 0:
		for i in range(hitCount):
			var collision = get_slide_collision(i)
			if collision.collider is RigidBody:
				collision.collider.apply_impulse(collision.position, -collision.normal * 20)
	
func save():
	var save_dict = {
		player_stats = {
			jump = jump
				}
		}
	return save_dict
	