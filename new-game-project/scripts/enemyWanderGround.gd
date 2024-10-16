extends State
class_name enemyWander

@export var maxWanderTime : float  = 4

var enemyAI
var moveDirection
var wanderTime


func _ready():
    enemyAI =get_parent().get_parent()
    pass

func randomizeWander():
    moveDirection = int(randf_range(-1, 1))
    wanderTime = randf_range(1, maxWanderTime)
    pass

func _physics_process(delta):
    enemyAI.velocity.x += enemyAI.speed * -1
    pass
    
func enter():
    randomizeWander()
    pass

func update(delta: float):
    if wanderTime > 0: #checks if there is a wander time
        wanderTime -= delta
    else:
        randomizeWander()
    if wanderTime < 0:
        Transitioned.emit(self, "idle")

func exit():
    pass 

func physicsUpdate(delta):
    pass
