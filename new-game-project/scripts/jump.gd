extends Node

var Player  # Reference to the Player node
var stateMachine # Reference to the StateMachine node

func _ready():
    
    Player = get_parent().get_parent() # Reference to Player node
    stateMachine = get_parent() # Reference to Player node
    pass

func set_active():
     
    Player.velocity.y -= Player.jumpHeight 
    pass
    
func _physics_process(delta):  

    pass
    
