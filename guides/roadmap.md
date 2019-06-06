# Comgen Roadmap

## Goals

I'm writing a financial app that needs Event Sourcing for failover and audit
trail.  Commanded fits our app, but the learning curve is big.  

EventSourcing and CQRS are hard to ingest.  Beyond that, there are some
characteristics of Commanded that IMO make onboarding more difficult.

First is the lack of a standard directory structure.  The directory structure
for every app I see is different, and for each app it takes awhile to figure
out what's what.

Second is that there is no blueprint for a Commanded app - the design intent
is spread across many files.  I hope that a `comspec` will serve as a blueprint
to show at a glance how all the elements of a Commanded app fit together.

My hope is for Comgen to create resources that are API-compatible with assets
produced by `mix phx.gen context`, to work interchangably.

Also: by using pre and post hooks, I hope that `comspecs` can be chained
together, to compose applications from disparate specs. 

The core goal is to reduce the barriers for new developers, to help grow a
healthy Event Sourcing community for Commanded.

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

