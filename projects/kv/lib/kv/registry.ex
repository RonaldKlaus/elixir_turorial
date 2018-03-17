defmodule KV.Registry do
  use GenServer

  ## Client API

  @doc """
  Starts the registry
  """
  def start_link(opts) do
    # __MODULE__ is the module, where the server callbacks are implemented (__MODULE__ is like `this`)
    # the initialize argument, in this case, is the atom :ok
    # `opts` is a list of options (like the server name)
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up the bucket pid for `name` stored in `server`.

  Returns `{:ok, pid` if the bucket exists, `:error` otherwise.
  """
  def lookup(server, name) do
    # calls: synchronous, server must send request
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Ensures there is a bucket associated with the given `name` in `server`.
  """
  def create(server, name) do
    # casts: asynchronous, server won't send a response
    GenServer.cast(server, {:create, name})
  end

  @doc """
  Stops the registry.
  """
  def stop(server) do
    GenServer.stop(server)
  end

  ## Server Callbacks

  # it receives the second argument of `GenServer.start_link/3`
  # it returns `{:ok, state}`, where state is a new Map
  def init(:ok) do
    # two dictionaries
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  # it handles `call/2`
  # _from: the process from which we received the request
  # {names, _}: current server state
  def handle_call({:lookup, name}, _from, {names, _} = state) do
    # it returns a tuple {:reply, reply, new_state}
    # :reply indicates, that the server must reply
    # Map.fetch(names, name): is the reply
    # names: is the new state
    {:reply, Map.fetch(names, name), state}
  end

  # it receives the request (`{:create, name}`) and the current server state (`names`)
  # in a real app we would implement :create as call, to receive a response
  def handle_cast({:create, name}, {names, refs}) do
    if Map.has_key?(names, name) do
      {:noreply, {names, refs}}
    else
      {:ok, pid} = KV.Bucket.start_link([])
      # monitor the pid
      ref = Process.monitor(pid)
      refs = Map.put(refs, ref, name)
      names = Map.put(names, name, pid)
      {:noreply, {names, refs}}
    end
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    names = Map.delete(names, name)
    {:noreply, {names, refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
