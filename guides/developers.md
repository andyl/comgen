# Comgen Roadmap

## Goals

I'm working on a financial app that needs Event Sourcing, especially for
hot-backups and audit trail.

Commanded fits our app, but the learning curve is big.  

EventSourcing and CQRS big topics themselves.  Beyond that, there are a couple
of characteristics of Commanded that I think make onboarding more difficult.

First is that I haven't seen people using a standard directory structure for
their Commanded apps.  The directory structure for every app I see is
different, and it takes me awhile just to figure out what's what.

Second is that there is no blueprint for a Commanded app - the design outline
is spread across many files.  I hope that a `comspec` will serve as a blueprint
to show at a glance how all the elements of a commanded app fit together.

My hope is for Comgen to create resources that are API-compatible with assets
produced by `mix phx.gen context`, to work interchangably.

Also: by using pre and post hooks, I hope that `comspecs` can be chained
together, to compose applications from sub-specs.

The core goal is for Comgen generators and conventions to help lower the
barriers for new developers, to grow a healthy EventSourcing community for
Elixir.

## Roadmap

| Type      | Item           | Description                               |
|-----------|----------------|-------------------------------------------|
| Ingestion | YAML Loader    | Define comspecs in a YAML file            |
| Hooks     | Shell Command  | Launch a shell command in a pre/post hook |
| Hooks     | Comspec        | Run another comspec in a pre/post hook    |
| Training  | Comguide       | Spec for guided training                  |
| Basic     | Validator      | Validate comspecs before running          |
| Admin     | Dashboard Page | LiveView w/events, telemetry ...          |
| Admin     | Elements Map   | [zdenal/commanded_events_map][1]          |

[1]: https://github.com/zdenal/commanded_events_map


