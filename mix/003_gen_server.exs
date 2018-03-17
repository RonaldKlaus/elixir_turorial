# - since agents are processes, each process has a pid and optional a name
Agent.start_link(fn -> %[] end, name: :shopping)
KV.Bucket.put(:shopping, "milk", 1)
KV.Bucket.get(:shopping, "milk")
# - however: WE DO NOT WANT ATOMS AS NAMES FOR DYNAMIC PROCESSES
#   - we have to convert the input always into atoms!
#   - we should NEVER convert user input into atoms!
#   - ATOMS ARE NOT GARBAGE COLLECTED!!

# - so instead of generating always new names, we generate our own 'process registry'

### Specification
# - it has to be always up to date
# - if one bucket craches, the registry has to notice and handle with it
# - the registry needs to 'monitor' each bucket

#################
### GenServer ###
#################
# - a GenServer is implemented in two parts:
#   1. Client API
#   2. Server Callbacks
# - they can either be combined in one module or seperated into client & server module
# - client and server run in seperate processes
# - the client passinge messages back and forht to the server

### Single Module Version (see registry.ex)

## Client API ##
#  ----------
# - there are 2 types of requests you can send to a GenServer: calls & casts
#   Calls: synchronous, the server MUST send a response back to such request
#   Casts: asynchronous, the server WON'T send a requst back

# - `lookup/2` and `create/2` are resonsible for sending requests to the server
# - arguments are `{:lookup, name}` and `{:create, name}`
# - it is common to use tuples as arguments
# - they have to match `handle_call/3` and `handle_cast/3` in the "Server Callbacks"

## Server Callbacks ##
#  ----------------
# - here we can implement a variety of callbacks
# - to guarantee the server initialization, termination & handling of requests
# - these callbacks are optional

# - `init/1` receives the second argument from GenServer.start_link/3
# - `handle_call/3` handles `call/2` requests
#   - it returns `{:reply, reply, new_state}`
# - `handle_cast/3` handles `cast/2` requests
#   - it returns `{:reply, new_state}`
# - there are other callbacks (like `terminate/2` or `code_chante/3`) and tuple we could implement, but this is it for now
# - for monitoring we implement `handle_info/2`
#   - it handles everything, what is not `call/2` or `cast/2`

## Monitoring
# - we need the registry to monitor every bucket that respawnes
# - otherwise we couldn't see, when a bucket process has been killed/stoped
# - once we set up a monitor, the registry will receive a notification every time a bucket process exits
# - that allows us to clean up the registry
# - we can monitor a process via:
Process.monitor(pid)
# - it returns a unique reference, that allows us to match upcomming messages to that reference
# - after stopping the agent (`Agent.stop(pid)`), we can `flush/0` all messages
# - we notice `:DOWN` > That comes from `Process.monitor(pid)`

