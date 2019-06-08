defmodule PhoenixCommanded.MixProject do
  use Mix.Project

  defp version, do: "0.0.5"

  defp deps do
    when_configured = Application.get_all_env(:commanded) != []
    when_using_estore = when_configured

    [
      # utilities
      {:rop, "~> 0.5"},
      {:jason, "~> 1.1"},
      {:inflex, "~> 1.10.0"},
      {:table_rex, "~> 2.0.0"},
      {:typed_struct, "~> 0.1.4"},
      # phoenix
      {:phoenix, "~> 1.4.6"},
      # commanded
      {:commanded, "~> 0.18", runtime: when_configured},
      {:eventstore, "~> 0.16.1", runtime: when_using_estore},
      {:commanded_ecto_projections, "~> 0.8"},
      {:commanded_eventstore_adapter, "~> 0.5", runtime: when_using_estore},
      # development and testing
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false},
      # static analyzers
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false},
    ]
  end

  # ----------------------------------------------

  def project do
    [
      app: :comgen,
      version: version(),
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      applications: [:table_rex],
      extra_applications: [:logger]
    ]
  end

  defp docs do
    [
      main: "readme",
      assets: "assets",
      extra_section: "GUIDES",
      extras: [
        "README.md",
        "guides/roadmap.md"
      ]
    ]
  end
end
