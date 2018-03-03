###################
### Enumerables ###
###################
# - a module with functions for maps and lists
Enum.map([1, 2, 3], fn x -> x * 2 end)
Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end)
# - it also provides ranges
Enum.map(1..3, fn x -> x * 2 end)
# - all functions here a limited to enumerables
# - for other specific functions you have to load other modules, like List.insert_at/3
# - the functions a polymorphic, since they can work with any datatype the implements the Enum protocol
# - all functions are eager, that means, that they are returning a list back

odd? = &(rem(&1, 2) != 0)
1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum # 7500000000

# - here we are using the pipe operator |>
# - it pipes the result of the function as the first parameter of the next function

###############
### Streams ###
###############
# - is the lazy alternative to Enums
# - very usefull when working with large (infinitive) data
1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?)
# - the module also provides functions to create streams
stream = Stream.cycle([1, 2, 3])
Enum.take(stream, 10)