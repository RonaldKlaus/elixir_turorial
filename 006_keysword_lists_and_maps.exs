# Keyword lists and maps
# - associative data structures -> key, value data structure

#####################
### keyword lists ###
#####################
# - is a list of tuples, where the first item of the tuple is an atom
list = [{:a, 1}, {:b, 2}] # [a: 1, b: 2]
list == [a: 1, b: 2] # true
list2 = [a: 1, b: 2] # also possible
# - cause it is a list, we can use all list operators, like `++`
list ++ [c: 3] # [a: 1, b: 2, c: 3]
[c: 3] ++ list # [c: 3, a: 1, b: 2]

# - if there are more tuple with the same key, it only returns the first one
list = [a: 0] ++ list # [a: 0, a: 1, b: 2, c: 3]
list[:a] # list[:a] is 0

# - 3 special characteristics
# 1. keys must be an atom
# 2. keys are ordered, specified by the programmer
# 3. keys can given more then ones

# - THIS IS THE NORMAL WAY TO PASS OPTIONS TO FUNCTIONS
# - EXAMPLE: if/2
if false, do: :this, else: :that
if(false, [do: :this, else: :that])
if(false, [{do: :this}, {else: :that}])

# - and we can do pattern matching 
# - but it is rarely done, cause we need the right number and order of the tuples
[a: a, b: 2] = [a: 4, b: 2] # OK
[a: 4, b: 2] = [a: a, b: 2] # OK 
[a: 4, b: 2] = [b: 2, a: a] # ERROR

############
### Maps ###
############
# - for a key-value structure we use maps
%{a: 1, b: "3", b: 4} # also possible:  %{a: 1, b: "3", b: 4}
# - a key can be everything
# - a map is not ordered

# - here we can use pattern matching
%{} = %{:a => 1, 2 => :b} # %{2 => :b, :a => 1}
%{:c => 3} = %{:a => 1, 2 => :b} # ERROR, :c => 3 doesn't exists

# - we can use variables as keys
# - the value will be the key
n = 1
map = %{n => 2} # {1 => 2}
map[n] # 2

# - carefull
%{n => 2} = %{1 => 2} # ERROR, variables are not allowed in matching, but...
%{^n => 2} = %{1 => 2} # OK, ... is allowed

# - with the Map module we have some functions to work with maps
Map.get(%{:a => 1, 2 => :b}, :a) # 1
Map.put(%{:a => 1, 2 => :b}, :c, 3) # %{:a => 1, 2 => :b, :c => 3}
Map.to_list(%{:a => 1, 2 => :b}) # [{2, :b}, {a: 1}]

# - for updating a value use
map = %{:a => 1, 2 => :b}
%{map | 2 => "two"} # %{2 => "two", :a => 1}
%{map | :c => 3} # ERROR, since :c is not a key in the map

# - if ALL keys are atoms, we can use the short syntax
%{:a => 2} = %{a: 2}

# - and we can get the values of the keys by map.field
map = %{a: 2, b: 3}
map.a # 2
map.b # 3

##############################
### Nested data structures ###
##############################
# - there are two functions to mutate nested data structures, put_in/2, update_in/2
users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]

# - put_in/2 changes the value of the key
users = put_in users[:john].age, 31

# - update_in/2 does the same, but we define a function to change a value
users = update_in users[:mary].languages, fn languages -> List.delete(languages, "Clojure") end

# - there a a log more function to check out, like
#   get_and_update_in/2
#		put_in/3
#		update_in/3

