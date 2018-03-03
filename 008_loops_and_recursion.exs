#################
### Recursion ###
#################
# - since in Elixir everything is immutable, we can not write loops and change data
# - therefore Elixir uses recursion

defmodule Recursion do
	# this is also names `base case`
	def print_multiple_times(string, n) when n <= 1 do
		IO.puts(n)
	end

	def print_multiple_times(string, n) do
		IO.puts(string)
		print_multiple_times(string, n - 1)
	end
end

##############################
### Reduce & map algorithm ###
##############################
# - it is the procest by taking a list and mapping over it

defmodule Math do
  def sum_list([head | tail], accumulator) do 
		sum_list(tail, head + accumulator)
	end

	def sum_list([], accumulator) do
		accumulator
	end
end

IO.puts Math.sum_list([1, 2, 3], 0) # 6

# - in real live this kind of recursion is very rare, since the Enum module provites a lot of map algorithms
Enum.reduce([1, 2, 3], 0, fn(x, acc) -> x + acc end) # it is the example above
Enum.reduce([1, 2, 3], 0, &+/2) # this is with capture syntax of the `+` method