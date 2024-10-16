extends Node

var Player  # Reference to the Player node
var stateMachine # Reference to the StateMachine node

func _ready():

    Player = get_parent().get_parent() # Reference to Player node
    stateMachine = get_parent() # Reference to Player node
    pass

func set_active():
    if Player.is_on_wall():
        Player.velocity.x = Player.wallJumpForceX if Player.transform.x.x == -1 else -Player.wallJumpForceX
        Player.transform.x.x *= -1
        #Player.velocity.x = Player.wallJumpForceX if Player.get_node("AnimatedSprite2D").flip_h else -Player.wallJumpForceX
        #Player.get_node("AnimatedSprite2D").flip_h = !Player.get_node("AnimatedSprite2D").flip_h
        Player.velocity.y -= Player.wallJumpForceY
        Player.move_and_slide()
    pass

func _physics_process(delta):

    if Input.is_action_just_released("Jump") and Player.velocity.y < 0:
        Player.velocity.y = Player.jumpHeight / 4

    pass
