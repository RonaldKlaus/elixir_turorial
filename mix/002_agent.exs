# - Elixir is immuteable, so we can not easily share stored data
# - to do so, we have 2 options: Processes or Erlang Term Storage(ETS)
# - ETS will be covered later, so we use the abstractions available in Elixir & OTP

### Agents ###
# - simple wrapper around states

### Gen Server ###
# - Processes that encapsulate state
# - provide sync and async calls
# - support code reloading, and more

### Task ###
# - Asynchronous units of computation
# - allow spawning a process and potentially retrieving its result at a later time (as a tuple)


##############
### Agents ###
##############
# - https://hexdocs.pm/elixir/Agent.html
# - wrapper around states (states are a possibility to store stuff, like configs or a file)
# - so if you want to keep a process in a state, agents are great for it

### Example ###
# - in the project folder, call `$ iex -S mix`

# 1. Starting an agent with an initial state
{:ok, agent} = Agent.start_link fn -> [] end
# 2. Updating the state and add a new item at the beginning of the list
Agent.update(agent, fn list -> ["eggs" | list] end)
# - Agent.update/3 arguments
#   1. `agent`
#   2. function, that get the current state as input and returns the new state
#   3. timeout (standard 5000) (not used here)
# 3. Show the state of the agent
Agent.get(agent, fn list -> list end) # ["eggs"]
# 4. Stop the agent
Agent.stop(agents)

# - now we wright a test (see at project)
# - start with `mix test`
# - more information about ExUnit: https://hexdocs.pm/ex_unit/ExUnit.Case.html


###############################
### client/server in agents ###
###############################
# - very imported:
#   - everything outside a function, that is passed to the Agent function, like delete, is executed on the client
#   - everything in the function is executed on the server

def delete(bucket, key)
  Process.sleep(1000) # executed at the client
  Agent.get_and_update(bucket, fn dict ->
    Process.sleep(1000) # executed at the server
    Map.pop(dict, key)
  end)
end

# - when there are long actions on the server, all other requests to that particluar server will wait
# - so some clients could have a timeout
