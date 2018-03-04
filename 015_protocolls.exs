#################
### Protocols ###
#################
# - mechanism to achive polymorphism
# - it is a "kind" of an interface/decorator/concern thing, what we can use for modules
# - you can define protocols for:
#   + Atom
#   + BitString
#   + Float
#   + Function
#   + Integer
#   + List
#   + Map
#   + PID
#   + Port
#   + Reference
#   + Tuple

# - defining a protocol
defprotocol Protocol do
  def some_function()
end

# - implementing this protocol to a data type
defimpl Protocol, for: String do
  def some_function(), do: true
end

# - an example

defprotocol Size do
  @doc "Calculates the size (and not the length!) of a data structure"
  def size(data)
end

defimpl Size, for: BitString do
  def size(string), do: byte_size(string)
end

defimpl Size, for: Map do
  def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple)
end

# example call
Size.size({:ok, "Hello"})

# - defining protocols for structs is also possible
defmodule User do
  defstruct [:name, :age]
end

defimpl Size, for: User do
  def size(_user), do: 2
end

# - instead of defining protocols for every data type we can use `any`
defimpl Size, for: Any do
  def size(_), do: 0
end

# - we can tell structs to derive (ableiten) this Size protocol
defmodule OtherUser do
  @derive [Size]
  defstruct [:name, :age]
end

# example call
Size.size(%OtherUser{name: "Ronald"})
