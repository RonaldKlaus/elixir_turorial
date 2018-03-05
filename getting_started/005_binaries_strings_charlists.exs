string = "Hello"
is_binary(string) # false

charlist = 'Hello'
is_binary(charlist) # false

###############
### Strings ###
###############
# - binary representation
# - UTF-8 encoded
# - you can get the codepoint of an character by ?

?a #97

String.codepoints(string) # ["H", "e", "l", "l", "o"]

# Binaries 
# - you can define binaries by
<<0, 1, 2>>
# - concatination for binaries works like for Strings (cause they are the same)
<<0, 1>> <> <<2, 3>> #<<0, 1, 2, 3>>

# - so you can conacatinate a string with a binary
# - in this example we add null representation to the string to get 
#   the binary representation of the string
string <> <<0>>

# - we can also pattern match on binaries
<<0, 1, x>> = <<0, 1, 2>> # <<0, 1, 2>>
x # 2

################
### Charlist ###
################
# - it is just a list of code points
list = 'hełło' # [104, 101, 322, 322, 111] # <- output like this, cause code poits are outside ASCII-Range

to_string(list) # "hełło"
# it is polymorphic and converts also integer, atoms, etc.
