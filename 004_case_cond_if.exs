### case ###
# compare a value agains many pattern

case {1, 2, 3} do
	{4, 5, 6} ->
		"This won't match"
	{1, x, 3 } ->
		"This matches and binds x to 2"
	_ ->
		"This would match any value"
end

# you can also use the pin operator if you want to match the binded value
x = 1
case 10 do
	^x -> "This won't match"
	_ -> "This will match any value"
end

# you can define an extra (guard) condition
case {1, 2, 3} do
	{1, x, 3 } when x > 0 ->
		"Will match"
	_ ->
		"This would match any value"
end

# Errors in guards will simply make the guard fail
# hd(1) would raise an error, but not here
case 1 do
	x when hd(x) -> "Won't match"
	x -> "Got #{x}"
end

# if no clause matches, an error is raised
case :ok do 
	:error -> "Won't match"
end

# anonymous functions can also have clauses and guards
f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end

f.(1, 3)
f.(-1, 3)

# the number of arguments in every clause must be the same
f = fn
  x, y when x > 0 -> x + y
  x, y, z -> x * y * z # ERROR
end

### cond ###
# usefull when you have to match against different values
# similar to else-if construct
x = 1
cond do 
	2 + x == 5 -> "#2 + #{x} is 5"
	2 * x == 2 -> "#{x} is 1"
	x * x > 0 -> "It's a big one"
end

# we don't have an else, but we can have a condition true
cond do 
	2 + x == 5 -> "#2 + #{x} is 5"
	2 * x == 2 -> "#{x} is 1"
	true -> "Got #{x}"
end

# cond considers any values besides nil and false to be true

### if, else, unless
if x == 1 do
	"This is 1"
else 
	"This is not 1"
end

if x == 1, do: "This is 1", else: "This is not 1"