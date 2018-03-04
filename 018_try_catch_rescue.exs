# - 3 mechanisms for handling errors
# - but it is very uncommon to use these things (only in special cases)

##################################
### errors, rescue, try, catch ###
##################################
# - use `raise` to raise an exception
raise "Ooops"
raise ArgumentError, message: "invalid argument foo"

# - define own Errors
defmodule MyError do
  defexception message: "default message"
end

raise MyError
# ** (MyError) default message
raise MyError, message: "custom message"
# ** (MyError) custom message

# - you can rescue errors with `rescue`
try do
  raise "Ooops"
rescue
  RuntimeError -> "Error!"
end
# "Error!"

# - try/rescue is not so often used in Elixir ("Let's break it")
# - for example to read a file it returns a tuple with  {:ok, body} or {:error, error}
# - we can handle it in a case construct

