###############
### structs ###
###############
# - like maps, but with checks at compile-time and default variables

defmodule User do
  defstruct name: "John", age: 27
end

# - creating a User struct

%User{} # with the defaults
%User{age: 27, name: "John"}
%User{name: "Ronald"} # set the name to Ronald
# - since they are created at compile time, you can only set attributes they are
#   created with defstruct
%User{alias: "Blabla"} # Is not working

#### accessing and updating
# - since they are build on top of maps, you can use the same syntax here
john = %User{}
john.name

# - withe the | operator, the VM knows, that john and meg are gonne share the same key structure
meg = %{john | name: "Meg"}

# they can alos be used in pattern matching
%User{name: name} = john
name # "John"

# - we can define a struct without initial values
defmodule User do
  # @enforce_keys [:age] # <- with this we can force that certain keys has to be specified
  defstruct [:name, :age]
end
