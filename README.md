# PhoenixCommanded

A [Commanded][com] code generator for [Phoenix][phx] applications.  This is
UNDER CONSTRUCTION, not ready for live use!

The intended audience is new Commanded developers, to get experimental apps up
and running quickly.  

Experienced Commanded developers can bypass this scaffolding and use the
Commanded tooling directly.

We will explore how to generate a Commanded app from a data-structure like
[GraphQL SDL][sdl]. (we call our data-structure a `comspec`)  To guide the
work, we'll loosely follow the directions in [Event Sourcing with Elixir][ese]
by Bruno Antunes.  

Find our `comspec` template at `priv/templates/phxcom.add.config/comspec.exs`
(a work-in-progress...)

I'll slowly chip away at this, and welcome collaborators and PRs.  Chat about
Commanded on [Gitter][gtr] or [Slack][slk].

[com]: https://github.com/commanded/commanded
[phx]: https://phoenixframework.org
[sdl]: https://graphql.org/learn/schema
[gtr]: https://gitter.im/commanded/Lobby
[slk]: https://elixir-lang.slack.com
[ese]: https://blog.nootch.net/post/event-sourcing-with-elixir/

## Instructions

First, generate an API-only Phoenix app:

```
$ mix phx.new my_app --no-webpack --no-html
$ cd my_app
```

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

Then run mix commands to configure your app and generate code.

```
$ mix deps.get
$ mix phxcom.add.config   # add Commanded config w/comspec
$ mix phxcom.add.estore   # add Commanded event-stores
$ mix phxcom.gen.code     # generate Aggregates, Commands, Events, ...
```

At this point, you'll have a set of generated directories and source files.
You'll have to manually fill out the code stubs, then you can compile and run
your application.

```
$ mix compile             # compile the generated code
$ mix ecto.setup          # setup read-store
$ mix phx.server          # run server
```

In another terminal view your API endpoints with `$ mix phx.routes`.

Now you can use `curl` or your favorite rest-client to interact with your
Phoenix/Commanded application.

## Mix Commands

Run `$ mix phxcom` to see all generators and generator options.

## The Comspec

Phxcom code generation is specified as a configuration option in the file
`config/comspec.exs`. 

You can view the comspec with the command `$ mix phxcom.show.comspec`.

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

Context API: We generate the same API interface as is used by the standard
Phoenix/Ecto generators.  Your Commanded contexts should be interoperable with
a Phoenix-generated context, and should work seamlessly with Phoenix-generated
views.

