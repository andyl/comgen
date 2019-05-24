# PhoenixCommanded

[Commanded][com] support for the [Phoenix Framework][phx]

This repo is to experiment with generators, templates etc. for rapid
development Phoenix/Commanded apps.

The generators use a file-system layout described in a [google doc][doc].  Please
check it out, leave comments and re-use the content.

[doc]: https://docs.google.com/document/d/1wks-6lO_MVguOYkETUDRg4tPxHvVgIPCPxObwUHvj14/edit
[com]: https://github.com/commanded/commanded
[phx]: https://phoenixframework.org


## Installation

First, generate a Phoenix app:

    mix phx.new MyApp

This package can be installed by adding `phoenix_commanded` to your list of
dependencies in `my_app/mix.exs`:

```elixir
def deps do
  [
    {:phoenix_commanded, git: "https://github.com/andyl/phoenix_commanded"}
  ]
end
```

After the package is installed, view the list of `phx-cmd` code generators
using `mix help`.
