defmodule PhoenixCommanded.MixProject do
  use Mix.Project
  use Mix.Config

  defp version, do: "0.1.0"

  defp deps do
    when_configured = Application.get_all_env(:commanded) != []
    # when_using_estore = when_configured && Mix.env() != :test
    when_using_estore = when_configured

    [
      {:jason, "~> 1.1"},
      {:inflex, "~> 1.10.0"},
      {:phoenix, "~> 1.4.6"},
      {:commanded, "~> 0.18", runtime: when_configured},
      {:eventstore, "~> 0.16.1", runtime: when_using_estore},
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
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end
end
