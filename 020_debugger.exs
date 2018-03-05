####################
### IO.inspect/2 ###
####################
# - inspects the given data
# - commen use to see all variales: IO.inspect binding()
def some_fun(a, b, c) do
  IO.inspect binding()
end

#################
### IEx.pry/0 ###
#################
# - can be used instead of IO.inspect binding()
def some_fun(a, b, c) do
  require IEx; IEx.pry
end
# - kind of breakpoint
# - the code stops and you will be asked to pry
# - now you can check all veriables and stuff
# - type `continue` return to code excecution

# - there are also debugger and observer to use
# - observer are very important to understand bigger systems and structures
