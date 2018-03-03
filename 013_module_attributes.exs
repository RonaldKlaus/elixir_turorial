# - module attributes serves 3 purposes
# 1. Annotation: informations about a module and how to use it
# 2. Constants: like the name said
# 3. Tempory storage: they work as temporary module storage to be used during compilation

######################
### As annotations ###
######################
# - there are many of them, like @vsn
# - most common are two: @moduledoc and @doc

defmodule Math do
  @moduledoc """
  Provides math-related functions.

  ## Examples

      iex> Math.sum(1, 2)
      3

  """

  @doc """
  Calculates the sum of two numbers.
  """
  def sum(a, b), do: a + b
end

# - you can call them from the console with h
h Math
h Math.sum

# - we can use ExDoc to generate HTML pages from the documentation

####################
### As constants ###
####################
defmodule MyServer do
  @initial_state %{host: "127.0.0.1", port: 3456}
  IO.inspect @initial_state
end

# - calling unkown constants will print a warning
defmodule MyServer do
  @unknown
end

# - and the constant can be read inside functions
# - but there will be red to COMPILED TIME
defmodule MyServer do
  @my_data 14
  def first_data, do: @my_data
  @my_data 13
  def second_data, do: @my_data
end

MyServer.first_data #=> 14
MyServer.second_data #=> 13

############################
### As temporary storage ###
############################
# - stores stuff temporary
# - an example are plugs in phoenix (the routes)
# - every plug definition will be stored in @plugs
