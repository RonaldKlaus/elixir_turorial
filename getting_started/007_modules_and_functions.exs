# - in Elixir we use modules to group functions, like String.length(str)

# math.ex
defmodule Math do
	def sum(a, b) do
		a + b
	end
end

# Compilation
# - we want to compile a file with a module with elixirc

elixirc math.ex

# - it creates `Elixir.Math.beam`
# - if we run iex in the same directory, we can use the math module
Math.sum(1, 2) # 3

# Folder-Structure
# - ebin -> the compiled bytecode
# - lib -> the ex files (Elixir code)
# - test -> the exs files (Test code)

# - when working with projects, we use `mix` to generate the right folder structure and setting up everything

#####################
### Scripted Mode ###
#####################
# - script files have the file extension `exs`
# - they are like `ex` files, but were not compiled
# - this is only a convention - it is possible the compile `exs` files ;)

#######################
### Named functions ###
#######################
# - inside a module we can define functions in different ways: `def/2` or `defp/2` (private)
defmodule Math do
  def sum(a, b) do
    do_sum(a, b)
  end

  defp do_sum(a, b) do
    a + b
  end
end

IO.puts Math.sum(1, 2)    #=> 3
IO.puts Math.do_sum(1, 2) #=> ** (UndefinedFunctionError)

# - we can use guards on the function definition
defmodule Math do
  def zero?(0) do
    true
  end

  # with guard
  def zero?(x) when is_integer(x) do
    false
  end
end
IO.puts Math.zero?(0)         #=> true
IO.puts Math.zero?(1)         #=> false
IO.puts Math.zero?([1, 2, 3]) #=> ** (FunctionClauseError)
IO.puts Math.zero?(0.0)       #=> ** (FunctionClauseError)

##########################
### Function capturing ###
##########################
# - capture a function and store it as a anonymous function
# - load `iex math.exs`
fun = &Math.zero?/1
fun.(0) # true

# - creating a function with capture syntax like
fun = &(&1 + 1) # it is the same like: fun = fn x -> x + 1
# - capturing a function from a module
fun = &List.flatten(&1, &2) 
# it is the same like: 
fun = &List.flatten/2
fun = fn (list, tail) -> List.flatten(list, tail) end

##########################
### Default attributes ###
##########################
# - name functions can have default attributes
defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end
IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world

# - if a function with default values has multiple clauses, we must create a function head without definition
defmodule Concat do
  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end
IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world
IO.puts Concat.join("Hello")               #=> Hello