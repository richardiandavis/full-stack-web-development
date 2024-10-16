extends CharacterBody2D

@export_group("Basic Movement")
@export var speed: float = 300.0 #X axis speed
@export_group("Basic Jump")
@export var jumpHeight: float = 600.0 #Y axis speed
@export var fallSpeed: float = 1500.0 #Y axis speed during fall
@export var inputBuffer: float = 0.04
@export var coyoteTimer: float = 0.04
@export_group("Advance Movement")
@export_subgroup("Dash")
@export var dashForce: float = 600
@export var dashDuration: float = 2
@export_group("Advance Jump")
@export_subgroup("Wall Jump")
@export var wallSlideSpeed: float = 100.0 #Y axis speed for wall jump
@export var wallJumpForceY: float = 400.0 #Y axis speed for wall jump
@export var wallJumpForceX: float = 800.0 #X axis speed for wall jump
@export_subgroup("Double Jump")
@export var jumpCount: int = 1  # Set to the desired jump count

var gameManager #Reference for Game Manager
var stateMachine  # Reference to the State_Machine node
var xInput #reference to input on horizontal axes
var wallJumpCoolDown = .02
var canJump := false
var coyoteJump := false
var remainingJumps #Reference for Jump Count
var canDash:= true
var dashing: = false
var wallSliding = false
var damaged:= false

var refState
var refY
var refX
var refXInput

func _ready():
    
    gameManager = get_parent()
    stateMachine = get_node("State_Machine")  # Get the State_Machine node
    remainingJumps = jumpCount  # Initialize remaining jumps
    pass


func _physics_process(delta):

    move_and_slide()
    collisionChecks()
    defineInput()
    baseStateSwitcher()
    stateMachine.call("updateState", delta)
    Timers()
    debug()
    pass

func collisionChecks():
    
    if is_on_floor() and velocity.y == 0:
        coyoteJump = true
    if !is_on_floor() and coyoteJump:
        await get_tree().create_timer(coyoteTimer).timeout
        coyoteJump = false
    pass

func defineInput():
    xInput = Input.get_axis("Move Left", "Move Right")
    if xInput == 1:
        #scale.x = xInput
        #set_scale(Vector2(xInput, scale.y))
        transform.x.x = xInput
    if xInput == -1:
        #scale.x = xInput
        #set_scale(Vector2(xInput, scale.y))
        transform.x.x = xInput
    # if xInput == 1:
    #     $AnimatedSprite2D.flip_h = false
    # if xInput == -1:
    #     $AnimatedSprite2D.flip_h = true
    # pass

func baseStateSwitcher():
    
    #run state
    if !xInput == 0 and velocity.y == 0 and !damaged and !dashing:
        stateMachine.setState("move")
    #dashState
    if Input.is_action_just_pressed("Dash") and !damaged and canDash:
        canDash = false
        dashing = true
    #jump states
    if Input.is_action_just_pressed("Jump") and !damaged and !is_on_floor() and !is_on_wall():
        canJump = true
        await get_tree().create_timer(inputBuffer).timeout
        canJump = false
    if (Input.is_action_just_pressed("Jump") or canJump) and !is_on_wall() and !damaged and (is_on_floor_only() or coyoteJump): 
        stateMachine.setState("jump")
    if Input.is_action_just_pressed("Jump") and !damaged and is_on_wall():
        stateMachine.setState("wall jump")
    #fall state
    if velocity.y > 0 && !str(stateMachine.currentState).begins_with("falling"):
        stateMachine.setState("falling")
    if xInput == 0 and velocity.y == 0 and !damaged:
        stateMachine.setState("idle")
    pass
    
    
func Timers():
    
    if dashing:
        await get_tree().create_timer(dashDuration).timeout
        canDash = true
        dashing = false
    pass

func debug():
    if refState != str(stateMachine.currentState):
        print("Current State: ", stateMachine.currentState)
    if refY != str(velocity.y):
        print("Y velocity: ", velocity.y)
    if refX != str(velocity.x):
        print("X Input: ", xInput)  # Should show -1, 0, or 1 depending on key presses
    if refXInput != str(xInput):
        print("X velocity: ", velocity.x) 
    
    refState = str(stateMachine.currentState)
    refY = str(velocity.y)
    refX = str(velocity.x)
    refXInput = str(xInput)
    
    pass
