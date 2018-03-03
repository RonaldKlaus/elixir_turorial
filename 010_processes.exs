#################
### Processes ###
#################
# - in Elixir, all code runs in processes
# - processes run isolated and communicate via messages
# - theses processes are extremly lightweighted
# - so it is very common to have a lot of them (100s or even 1000s)

#############
### spawn ###
#############
# - build in method that creates a process (without argument!!!)
pid = spawn fn -> 1 * 3 end
# - it returns a PID, but will be already dead, case it just executes the small function
Process.alive?(pid) # false

######################
### send & receive ###
######################
# - send a message to "ourself" (the currently running process)
send self(), {:hello, "world"}
# - this message is stored in the process mailbox
# - so we can define how to receive it in "ourself"
receive do
	{:hello, message} -> message
	{:world, message} -> "Nope"
end
# - here we can use also guards, case and many other clauses

parent = self()
spawn fn -> send(parent, {:hello, parent})
receive do
	{:hello, pid} -> "Hello from #{inspect pid}"
end

# - we can flush all messages of a process via `flush/1`

#############
### links ###
#############
# - we spawn processes in Elixir usaly as linked processes
spawn fn -> raise "Ohoh" end
# - we can link these process to another one to propagate the error message
self() # just checking, who is the parent
spawn_link fn -> raise "Ohoh" end
# - now we can see, that the shell process recogniced the error
# - the shell process will be exit, the IEx detects that and starts a new one (check self() ;))
# - in other languages we have to build try-catch stuff - in Elixir it it total ok, if there is an error

#############
### Tasks ###
#############
# - it is like a wrapper for spawn
# - we can use Task.start/1 and Task.start_link/1 instead of spawn/1 and spawn/2
# - we get more information about an error
# - and we receive {:ok, pid}, what can be handled from the supervisor (in supervision tree)
# - there are other functions in Task we will learn later

#############
### State ###
#############
# - if we want to save a state or parse a file and keep it in memory, we keep it as a state
# - it is a process that loops infinetly, maintain a state, send & receives messages
# - see KV example

# - we can also give the process a name and everyone who knowes that name can send messages
#   and manipulate the process state
{:ok, pid} = KV.start_link
Process.register(pid, :kv)
send :kv, {:get, :hello, self()}

# - this pattern is very common in Elixir Apps, but we often use `Agents` for that
# - it is just an abstraction around a state
# - this is the same behavior like the KV module
{:ok, pid} = Agent.start_link(fn -> %{} end)
Agent.update(pid, fn map -> Map.put(map, :hello, :world) end)
Agent.get(pid, fn map -> Map(map, :hello) end)
# - there is also an other very importend module: GenServer
# - that implements an API for building generic servers
# - you can build a supervision tree with it -> more detailed later in Mix and OTP guide