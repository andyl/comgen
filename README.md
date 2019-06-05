# Comgen

A code generator for the [Commanded][com] event-sourcing framework.  This is
UNDER CONSTRUCTION, not ready for live use!

The intended audience is new Commanded developers, to get experimental apps up
and running quickly.  

Experienced Commanded developers can bypass this scaffolding and use the
Commanded tooling directly.

We will explore how to generate a Commanded app from a data-structure like
[GraphQL SDL][sdl]. (our data-structure is called a `comspec`)  

Find `comspec` templates at `priv/templates/comgen.add.config/comspecs/*.exs`
(you'll see it's a work-in-progress...)

I'll slowly chip away at this, and welcome collaborators and PRs.  Chat about
Commanded on [Gitter][gtr] or [Slack][slk].

[com]: https://github.com/commanded/commanded
[sdl]: https://graphql.org/learn/schema
[gtr]: https://gitter.im/commanded/Lobby
[slk]: https://elixir-lang.slack.com

## Instructions

First, generate an API-only Phoenix app:

```
$ mix phx.new my_app --no-html --no-webpack
$ cd my_app
```

Then install this package by adding `phoenix_commanded` to your list of
dependencies in `my_app/mix.exs`:

```elixir
def deps do
  [
    {:comgen, git: "https://github.com/andyl/comgen"},
  ]
end
```

Run mix commands to configure your app and generate code.

```
$ mix deps.get              # get comgen dependencies
$ mix ecto.create           # create database for read-models
$ mix comgen.add.config     # add Commanded config w/comspecs
$ mix comgen.add.estore     # add Commanded event-stores
$ mix comgen.build Account1 # generate Aggregates, Commands, Events, ...
$ mix compile               # compile the generated code
$ mix test                  # run tests
$ mix phx.server            # run server
```

In another terminal view your API endpoints with `$ mix phx.routes`.

Now you can use `curl` or your favorite rest-client to interact with your
Phoenix/Commanded application.

## Mix Commands

Run `$ mix comgen` to see all generators and generator options.

## The Comspec

Comgen code generation is specified as a configuration option in the file
`config/comspec.exs`. 

You can view the comspecs with the command `$ mix comgen.show`.

## Commanded Elements

Each generated context will contain a standard set of Commanded elements.

| Element            | Directory            | Alias |
|--------------------|----------------------|-------|
| API                | /                    | User  |
| Aggregate          | aggregates/          | A     |
| Command            | commands/            | C     |
| Command/Middleware | commands/middleware/ | CM    |
| Command/Handler    | commands/handler/    | CH    |
| Command/Router     | commands/router/     | CR    |
| Command/Validator  | commands/validator/  | CV    |
| Event              | events/              | E     |
| Event/Handler      | events/handler/      | EH    |
| Event/Projector    | events/projector/    | EP    |
| Process Manager    | process_managers/    | PM    |
| Read Schema        | read_schemas/        | RS    |
| Read Query         | read_queries/        | RQ    |

Here's how the Commanded elements flow together...

![CommandedElements](assets/CommandedElements.jpg)

