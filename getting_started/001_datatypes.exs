### Datatypes ###
# int, bool, float, atom, list, map, tuple
### Operations
# +, -, *, /, div/2, rem/2, ++, --

# Functions
### Anonymous functions (are also Closures) ##
##############################################

# declaring function and pass it in varialble add
add = fn a, b -> a + b end
is_function(add)

# invoke with ., cause we want to be sure to use the anonymous function "add" and named function "add/2"
add.(1,2)

# we can call anonymous functions inside others
double = fn a -> add.(a,a) end
double.(3)

######################
### (linked) Lists ###
######################
[1, 2, true]
# Concatination/Substraction via ++/--
[1, 2, 3] ++ [4]
[1, 2, 3] -- [2]
# since Elixir is immutable, the operations always generates a new list!

# HEAD
list = [1, 2, 3]
hd(list) # Head: 1
tl(list) # Tail: [2, 3]

# ATTANTION
[104, 101, 108, 108, 111]

# 'list' < List of characters
# "List" < string

##############
### TUPLES ###
##############
# definition like a list
tuple = {:ok, "hello"}

elem(tuple, 1)
tuple_size(tuple)
# are stored in memory, so therefore very fast

# we can put an element on a specific position
put_elem(tuple, 1, "world")
tuple # what is the value?

### LIST OR TUPLES??? ###
# - Lists are stored in memory as linked list
# - each element has its value and points to the next element
# - accessing is therefore linear and can be expensive

# - Tuples are stored contiguously (reservered?) in memory
# - therefor accession the elements and getting the size are very fast
# - but changing is expensive, cause it creates a new tuple
# - often use for just reading data (like from a file)
File.read("/path/to/file")
{:ok, "... contents ..."}

### IMPORTANT ###
# the good thing: since everything is immutable, Elixir can share the 
# data from lists and tuples, since it always generate a new list/tuple.
# The new lists/tuple share the "old" values and only stores the changed one.

