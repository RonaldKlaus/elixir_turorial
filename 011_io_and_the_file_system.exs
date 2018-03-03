#####################
### The IO module ###
#####################
# - main mechanism for reading & writing

IO.puts "Hello World"
IO.gets "Yes or no?"

# - by default IO reads/write from standard input/output
# - we can change that by passing another parameter

IO.puts :stderr, "Hello World"

#######################
### The File module ###
#######################
# - module with functions to open files as IO devices
# - by default it opens a file in binary mode, so we have
#   to use IO.binread/2 and IO.binwrite/2

{:ok, file} = File.open "hello", [:write] # here we see it works with processes!
IO.binwrite file, "world"
File.close file
File.read "hello"

# - beside open/read/write/close there are a lot more functions
# - File has another variant of reading files with read!
# - that returns the content and not the tuple
# - use read if you want to handle different outcomes
# - use read! if you are expecting the file and want to handle the error easiere (since it return it directly)

case File.read(file) do
	{:ok, body} -> IO.puts "I should do something"
	{:error, error} -> IO.puts "something happened: #{error}"
end

#######################
### The Path module ###
#######################
# - module for manipulating or retrieving file system paths
# - it always returns a UTF-8 encoded string

###########################
### The StringIO module ###
###########################
# - controlls an IO device process that weaps a string
# - so we can use IO functions on it
{:ok, pid} = StringIO.open("hello")
IO.read(pid, 2) # he
