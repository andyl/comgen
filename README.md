# PhoenixCommanded

[Commanded][com] code generators for the [Phoenix Framework][phx].  This is 
UNDER CONSTRUCTION, not ready for live use!

This repo has generators for rapid creation of Phoenix/Commanded apps.  The
intended audience is new Commanded developers, to generate demo code and to get
experimental apps up and running quickly.  

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
    {:phoenix_commanded, git: "https://github.com/andyl/phoenix_commanded"},
  ]
end
```

Then run mix commands to configure and run your app.

```
$ cd my_app
$ mix deps.get
$ mix phxcmd.add.config    # add Commanded config
$ mix phxcmd.add.estore    # add Commanded event-stores
$ mix phxcmd.gen.code      # generate code 
$ mix compile              # compile code
$ mix ecto.create          # create read-store 
$ mix ecto.migrate         # migrate the read-store
$ mix test                 # run tests
$ mix phx.server           # run server
```

Now point your browser to `localhost:4000`.

## Mix Commands

Run `mix phxcmd` to see all generators and generator options.

## The Phxcom Genspec

Phxcom code generation is specified in the file `config/commanded.exs`.

You can view the genspec with the command `$ mix phxcmd.show.genspec`.

## Commanded Elements

Each generated context will contain a standard set of Commanded elements.

| Element            | Directory           | Alias |
|--------------------|---------------------|-------|
| API                | /                   | User  |
| Aggregate          | aggregate/          | A     |
| Command            | command/            | C     |
| Command Middleware | command/middleware/ | CM    |
| Command Handler    | command/handler/    | CH    |
| Command Router     | command/router/     | CR    |
| Command Validator  | command/validator/  | CV    |
| Event              | event/              | E     |
| Event Handler      | event/handler/      | EH    |
| Event Projector    | event/projector/    | EP    |
| Read               | read/               | R     |
| Read Schema        | read/schema/        | RS    |
| Read Query         | read/query/         | RQ    |
| Saga (ProcessMgr)  | saga/               | S     |

Here's how things look on the filesystem...

![CommandedElements](assets/Tree.jpg)

Here's how the Commanded elements flow together...

![CommandedElements](assets/CommandedElements.jpg)

## Design Notes

Database: We use Postgres for the Event Store, for `:dev`, `:prod` and `:test`

Context API: We use the same API interface as is used by the native Phoenix
Ecto generators.

