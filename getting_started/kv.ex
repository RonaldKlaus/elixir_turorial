# A small programm that starts new processes that work as key-value store in a file
# The main idea is that we send a message to the KV process and it sends us message back
defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        IO.puts "get: #{key}"
        # this just sends a message to the caller with the value in the map
        send caller, Map.get(map, key)
        # call loop again after sending
        loop(map)
      {:put, key, value} ->
        # put the value in the map and call loop again with the extended map
        # loop(Map.put(map, key, value)) # old implementation
        Map.put(map, key, value) |> loop # better implementation
    end
  end
end