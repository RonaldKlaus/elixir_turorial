### Supervisor ###
# - a process, that handles other processes and restarts them, if they crash
# - here we can handle the KV.Registry process by name, since there is only one registry process
# - in our example we have a regestry process to supervise (see `kv/supervisor.ex`)

###################
### Application ###
###################
# - when we run `mix compile` we are createing an application
# - see the generated `.app` file in `_build/dev/lib/kv/ebin/kv.app`
# - the configuration of the app is in the `mix.exs` file

# - start the application in the console `iex -S mix`
Application.start(:kv)
# - we get an error, since the application is already startet
# - we have to start the console without starting the application
#   `iex -S mix run --no-start`
# - now we can start the application with
Application.start(:kw)
# - and stop it with
Application.stop(:kw)
Application.stop(:logger) # we stop the auto startet by default process :logger
# - if we want to start :kv again, we got an error, cause :logger has to start first
# - we can start all application by hand or use
Application.ensure_all_started(:kv)
