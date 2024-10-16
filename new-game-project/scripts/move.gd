extends Node

var Player  # Reference to the Player node
var stateMachine # Reference to the StateMachine node

func _ready():
    
    Player = get_parent().get_parent() # Reference to Player node
    stateMachine = get_parent() # Reference to Player node
    pass

func set_active():
    
    pass
    
func _physics_process(delta):
    
    if Player.xInput != 0:
        if Player.dashing:
            Player.velocity.x += Player.dashForce * Player.xInput
        if !Player.dashing:
            Player.velocity.x += Player.speed * Player.xInput

    if Player.xInput == 0 and Player.velocity.y == 0 and !Player.damaged:
        stateMachine.setState("idle")
    pass
