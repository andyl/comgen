defmodule PhoenixCommanded.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_commanded,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.1"},
      {:commanded, "~> 0.18"},
      {:eventstore, "~> 0.16.1", runtime: Mix.env() != :test},
      {:commanded_eventstore_adapter, "~> 0.5", runtime: Mix.env() != :test},
    ]
  end
end
