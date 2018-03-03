#############
### alias ###
#############
# - for aliasing a module
alias Foo.Bar as: Bar # now you can call Bar without Foo
alias Foo.Bar # is the same, since as: is optional
# - alias is lexically scoped -> if defined in a function the alias is only useable in this function

###############
### require ###
###############
# - require a module to use its macros
# - a macro is a mechanism for meta-programming
# - for example Integer.is_odd/1, cause it is implemented as macro
# - it is also lexically scoped
require Integer

##############
### import ###
##############
# - import functions from a module so they can be called without the module
import Foo
# - we can also just import some functions (or don't import with except)
import List, only: [duplicate: 2]
duplicate :ok, 3
# - and we can import all functions or macros with theses keywords
import List, only: :macros
import List, only: :functions
# - it is also lexically scoped
# - importing something automatically `require`s is

###########
### use ###
###########
# - invokes the custom code defined in Foo as an extension point
use Foo

######################
### Module nesting ###
######################
defmodule Foo do
  defmodule Bar do

  end
end

# - it is possible to define Foo.Bar without defining the extra module Foo
defmodule Foo.Bar do
end
# - since elixir module names are compile in atoms like :"Foo.Bar"

# - it is possible to multi alias/import/require/use modules
alias MyApp.{Foo, Bar, Baz}
