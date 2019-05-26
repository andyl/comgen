# PhoenixCommanded

[Commanded][com] code generators for the [Phoenix Framework][phx]

This repo provides generators for rapid creation of Phoenix/Commanded apps.  

The intended audience is new Commanded developers, to generate demo code and to
get experimental apps up and running quickly.  

Experienced Commanded developers should not rely on these generators, and
should instead use the Commanded tooling directly.

The generators use a file-system layout described in this [google doc][doc]. 

[doc]: https://docs.google.com/document/d/1wks-6lO_MVguOYkETUDRg4tPxHvVgIPCPxObwUHvj14/edit
[com]: https://github.com/commanded/commanded
[phx]: https://phoenixframework.org

## Installation

First, generate a Phoenix app:

    mix phx.new my_app

Then install this package by adding `phoenix_commanded` to your list of
dependencies in `my_app/mix.exs`:

```elixir
def deps do
  [
    {...},
    {:phoenix_commanded, git: "https://github.com/andyl/phoenix_commanded"}
  ]
end
```

Then run a series of mix commands to configure your app.

```
$ mix deps.get
$ mix phxcmd.add.config
$ mix phxcmd.add.estore
$ mix phxcmd.gen.html TBD
```

Start your app with `mix phx.server`. Point your browser to `localhost:4000`.

## Mix Commands

Run `mix phxcmd` to see all generators and generator options.

