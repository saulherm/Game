extends KinematicBody2D
var speed  = 100
var velocity = Vector2()
#1 right and -1 left

export var direction = -1
onready var timer = get_node("Timer")
	

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Walk")
	$Stick.position.x = $hitbox/CollisionShape2D.shape.get_extents().x * direction
	$AnimatedSprite.play("Walk")
	
func _physics_process(delta):
	
	if is_on_wall() or not $Stick.is_colliding() and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$AnimatedSprite.play("walk")
		$Stick.position.x = $hitbox/CollisionShape2D.shape.get_extents().x * direction
	
	velocity.y += 20
	
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity,Vector2.UP)


func _on_Top_checker_body_entered(body):
	$AnimatedSprite.play("death")
	speed = 0
	$hitbox/CollisionShape2D.disabled = true
	$Top_checker/CollisionShape2D.disabled = true
	$Timer.start()
	body.bounce()

	
	
func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.

func _on_hitbox_body_entered(body):
	body.ouch()
	
#	pass # Replace with function body.










func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://World.tscn")
	pass # Replace with function body.
