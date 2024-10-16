extends Node2D

var Player  # Reference to the Player node
var stateMachine # Reference to the StateMachine node

func _ready():

    Player = get_parent().get_parent() # Reference to Player node
    stateMachine = get_parent() # Reference to Player node
    pass

func set_active():
    pass

func _physics_process(delta):
    #below block checks wall side and moves player toward the wall in the hopes that they continue colliding so they can continue sliding
    for i in Player.get_slide_collision_count():
        var collision = Player.get_slide_collision(i)
        var normal = collision.get_normal()
        if normal.x < 0:  # Wall on the right
            print("WALL ON RIGHT, MOVING RIGHT")
            Player.velocity.x += 10
        elif normal.x > 0:  # Wall on the left
            print("WALL ON LEFT, MOVING LEFT")
            Player.velocity.x -= 10

    if Player.velocity.y > Player.fallSpeed and !Player.is_on_wall():
        Player.velocity.y = Player.fallSpeed
    if Player.velocity.y > 0 and Player.is_on_wall():
        Player.velocity.y = Player.wallSlideSpeed
    else:
        if !Player.is_on_wall():
            print("NOT ON WALL")
        Player.velocity.y += Player.gameManager.gravity * delta
    pass
