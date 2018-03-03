### Match Operator
# =
x = 1
x

# it is called like this, because
1 = x
# 1
2 = x
# ERROR

# also usefull for matching more complex data
{a, b, c} = {:atom, "Ronald", 1}
[d, e] = {:atom, "Ronald"}

# ERROR: {a, b, c} = {:hello, "world"}
# ERROR: {a, b} = [1, 2]

# MORE INTERESSTING
{:ok, result} = {:ok, 42} # OK
{:ok, result} = {:error, :damn} # ERROR

# On lists to get head and tail
[head | tail] = [1, 2, 3]
# and we can prepand lists
list = [1, 2, 3]
prepanded_list = [0 | list]

# if a variable is mentioned more then once in a pattern, all refernces should bind to
# the same pattern
{x, x} = {1, 1} # OK
{x, x} = {1, 2} # ERROR

### The pin operator ###
# match against an existing variable's value and not rebinding it
x = 1
^x = 2

{:ok, result} = {:ok, 42}
{:ok, result} = {:ok, 43} # OK

result = 42
{:ok, ^result} = {:ok, 43} # ERROR

# Use _ to bind not interesting values
[head | _] = [:interesting, :not, :interesting]

# LIMITATIONS: You cannot use functions on the left side of the = operator
legnth([1, 2, 3]) = 3 # ERROR
