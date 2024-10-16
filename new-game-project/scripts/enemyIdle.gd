extends State
class_name enemyIdle

@export var maxIdleTime : float  = 4

var idleTime

func randomizeIdle():
    idleTime = randf_range(1, maxIdleTime)
    pass
    
func enter():
    randomizeIdle()
    pass

func update(delta: float):
    if idleTime > 0: #checks if there is a wander time
        idleTime -= delta
    else:
         randomizeIdle()
    if idleTime < 0:
        Transitioned.emit(self, "wanderGround")

func exit():
    pass

func physicsUpdate(delta):
    pass
    
