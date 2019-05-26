defmodule PhoenixCommanded.MixProject do
  use Mix.Project
  use Mix.Config
  
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
    is_configured = Application.get_all_env(:commanded) != []
    is_using_estore = is_configured && Mix.env() != :test
    [
      {:jason, "~> 1.1"},
      {:phoenix, "~> 1.4.6"},
      {:commanded, "~> 0.18", runtime: is_configured},
      {:eventstore, "~> 0.16.1", runtime: is_using_estore},
      {:commanded_eventstore_adapter, "~> 0.5", runtime: is_using_estore},
    ]
  end
end
