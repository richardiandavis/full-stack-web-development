extends CharacterBody2D

@export_group("Basic Movement")
@export var speed: float = 300.0 #X axis speed
@export var hasGravity: bool = true

var gm
var gravity

func _ready():
    gm = findGameManager("Game")
    if gm:
        gravity = gm.returnGravity()
    pass

func _physics_process(delta):
    move_and_slide()
    if hasGravity:
        velocity.y += gravity * delta
    else:
        return

func findGameManager(name: String) -> Node:
    var current: Node = self
    while current != null:
        if current is Node and current.name == name:
            return current
        current = current.get_parent()
    return null
