extends Node

var currentState = null  # The current state node (e.g., "idle", "run", etc.)

# Function to change the current state
func setState(new_state_name: String):
    #if currentState != null:
        #currentState.set_active(false)  # Deactivate the previous state

    currentState = get_node(new_state_name)  # Get the new state node by name
    currentState.set_active()  # Activate the new state

# Function to update the current state logic
func updateState(delta):
    if currentState != null:
        currentState._physics_process(delta)  # Delegate the state update to the active state
