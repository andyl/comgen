defmodule PhoenixCommanded.MixProject do
  use Mix.Project

  defp version, do: "0.0.2"

  defp deps do
    when_configured = Application.get_all_env(:commanded) != []
    when_using_estore = when_configured

    [
      {:jason, "~> 1.1"},
      {:inflex, "~> 1.10.0"},
      {:phoenix, "~> 1.4.6"},
      {:commanded, "~> 0.18", runtime: when_configured},
      {:eventstore, "~> 0.16.1", runtime: when_using_estore},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:commanded_ecto_projections, "~> 0.8"},
      {:commanded_eventstore_adapter, "~> 0.5", runtime: when_using_estore}
    ]
  end

  # ----------------------------------------------

  def project do
    [
      app: :phoenix_commanded,
      version: version(),
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp docs do
    [
      main: "readme",
      assets: "assets",
      extras: [
        "README.md",
      ],
    ]
  end


end
