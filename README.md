# PhoenixCommanded

[Commanded][com] code generators for the [Phoenix Framework][phx]

This repo provides generators for rapid creation of Phoenix/Commanded apps.  

The intended audience is new Commanded developers, to generate demo code and to
get experimental apps up and running quickly.  

Experienced Commanded developers should bypass this scaffolding and use the
Commanded tooling directly.

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

## Commanded Elements

Each generated context will contain a standard set of Commanded elements.

| Element            | Directory    | Module Name           | Abb. | Alias                               |
|--------------------|--------------|-----------------------|------|-------------------------------------|
| API                | /            | MyApp.User            | NA   | NA                                  |
| Aggregate          | aggregate/   | MyApp.User.Aggregate  | A    | alias MyApp.User.Aggregate, as: A   |
| Command            | command/     | MyApp.User.Command    | C    | alias MyApp.User.Command, as: C     |
| Command Middleware | com_mw/      | MyApp.User.ComMw      | CM   | alias MyApp.User.ComMw, as: CM      |
| Command Handler    | com_hand/    | MyApp.User.ComHand    | CH   | alias MyApp.User.ComHand, as: CH    |
| Command Router     | com_router/  | MyApp.User.ComRouter  | CR   | alias MyApp.User.ComRouter, as: CR  |
| Command Validator  | com_val/     | MyApp.User.ComVal     | CV   | alias MyApp.User.ComVal, as: CV     |
| Event              | event/       | MyApp.User.Event      | E    | alias MyApp.User.Event, as: E       |
| Event Handler      | ev_hand/     | MyApp.User.EvHand     | EH   | alias MyApp.User.EvHand, as: EH     |
| Event Projector    | ev_pro/      | MyApp.User.EvPro      | EP   | alias MyApp.User.EvPro, as: EP      |
| Process Manager    | proc_man/    | MyApp.User.ProcMan    | PM   | alias MyApp.User.ProcMan, as: PM    |
| Read Schema        | read_schema/ | MyApp.User.ReadSchema | RS   | alias MyApp.User.ReadSchema, as: RS |
| Read Query         | read_query/  | MyApp.User.ReadQuery  | RQ   | alias MyApp.User.ReadQuery, as: RQ  |

Here's the CLI view...

![CommandedCLI](assets/CLI.jpg)

Here's how the Commanded elements flow together...

![CommandedElements](assets/CommandedElements.jpg)

