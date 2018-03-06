##############################
### Open Telecom Platform ###
##############################
# - set of libraries that ships with erlang
# - are used to build robust, fault-tolerant applications

###########
### mix ###
###########
# - build tool that ships with erlang
# - provides tasks for creating, compiling & testing, managing the dependencies and much more
# - short overview with `$ mix help`

##############
### ExUnit ###
##############
# - test-unit base framework that ships with erlang

#####################################
### Create a new project with mix ###
#####################################
# `$ mix new kv --module KV`
# kv - project name
# KV - main module name (default would be Kv)

# - it creates our project
# - in there there is a mix.exs file that configurates the project
# - it also creates a lib/kv.ex file with the KV module implementation inside

# - now we compile it to generate the app
# `$ mix compile`
# - that generates a kv.app file and compiles kv.exs
# - all compiled artifacts are placed in the `_build` folder

# - after compiling we can start a iex session by running:
# $ iex -S mix

# - mix also generated the test file and prepare the module tests
# - running tests with `$ mix test`

### Formatter ###
# - mix comes with a nice foramtter module
# - by default it formats all `.ex` and `.exs` files
# - you can specify the formated files in `.formatter.mix`
# - run with: $ mix format`
# - for just checking without fixing run: `$ mix format --check-formatted`


### Environments ###
# - :dev, :test, :prod
# - it is defined in the mix.exs file
# - to start in another environment change it there (useally not recommended) or start:
#   MIX_ENV=prod mix compile
