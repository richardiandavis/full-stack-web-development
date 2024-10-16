extends Node2D

@export var initialState: State #defines the default state

var currentState : State
var states: Dictionary = {}

func _ready():
    #checks the states within the Child Nodes
    for child in get_children():
        if child is State:
            states[child.name.to_lower()] = child
            child.Transitioned.connect(onChildTransition) #connects the signal any time a new state is registered
    
    if initialState: #checks if initial state exists, enters it, and sets it to current state
        initialState.enter() 
        currentState = initialState
    
    pass 

func _process(delta):
     #checks the current state
    if currentState:
        currentState.update(delta)
    pass
    
func _physics_process(delta):
    #fires the update method in the current state tied to a physics process
    if currentState:
        currentState.physicsUpdate(delta)

func onChildTransition(state, newStateName):
    if state != currentState: #checks if the state calling is not the current state
        return
    var newState = states.get(newStateName.to_lower()) #grab new state from state dictionary
    if !newState:
        return
    if currentState:
        currentState.exit() #checks if there is a current state, if so exit
    newState.enter() #calls enter on the new state
    currentState = newState #sets the new state to the current state
    pass
