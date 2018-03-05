# - we can map or filter enumerables in Elixir
# - comprehensions group these tasks with `for`

############################
### Generators & filters ###
############################

# - an exmaple for a generator
for n <- [1, 2, 3], do: n * n
# [1, 4, 9]

# - it also supports pattern matching
# - all non matching pattern will be ignored
values = [good: 1, good: 2, bad: 3, good: 4]
for {:good, n} <- values, do: n * n
# [1, 4, 16]

# - we can also filter with functions
multiple_of_3? = fn(n) -> rem(n, 3) == 0 end
for n <- 0..5, multiple_of_3?.(n), do: n * n
# [0, 9]

# - comprehensions discards all `false` or `nil` values

# - they also allow multiple generators and filters to be given
dirs = ['/home/mikey', '/home/james']
for dir  <- dirs,
    file <- File.ls!(dir),
    path = Path.join(dir, file),
    File.regular?(path) do
  File.stat!(path).size
end

# - or for calculation (cartesian product)
for i <- [:a, :b], j <- [1, 2], do: {i, j}
# [a: 1, a: 2, b: 1, b: 2]

# - or more advanced for the pythagorean triple
n = 12
for a <- 1..n,
  b <- 1..n,
  c <- 1..n,
  a + b + c <= n,
  a*a + b*b == c*c,
  do: {a, b, c}

# - this implementation is expensive and not well done since we have duplicate tuples
for a <- 1..n-2,
  b <- a+1..n-1,
  c <- b+1..n,
  a + b >= c,
  a*a + b*b == c*c,
  do: {a, b, c}

# - generators can also be used with bitstrings
# - theyfore the are very useful when you need to comprehend over bitstring streams (like images)
pixels = <<213, 45, 132, 64, 76, 32, 76, 0, 0, 234, 32, 15>>
for <<r::8, g::8, b::8 <- pixels>>, do: {r, g, b}

# - the result of a generator can be stored in another data type or variable with :into
for <<c <- " hello world ">>, c != ?\s, into: "", do: <<c>>

# - stream the input and make it big
stream = IO.stream(:stdio, :line)
for line <- stream, into: stream, do: String.upcase(line) <> "\n"

