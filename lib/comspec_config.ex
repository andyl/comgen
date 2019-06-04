defmodule ComspecConfig do
  @moduledoc """
  List and select from the set of comspecs defined in `config/comspecs/*.exs`.
  """

  @doc """
  Get a list of all defined comspec keys.

  The comspecs are defined in `config/comspecs/*.exs`.
  """
  def keys do
    app_key = case Mix.env() do
      :test -> :comgen
      _ -> :comspecs
    end
    Application.get_all_env(app_key)
    |> Keyword.keys()
    |> Enum.sort()
  end

  @doc """
  Comspec keys as strings.
  """
  def string_keys do
    keys()
    |> Enum.map(&to_string(&1))
    |> Enum.map(&String.replace(&1, ~r/Elixir./, ""))
  end

  @doc """
  Key in keys?
  """
  def valid_key?(key) do
    skey = to_string(key)
    Enum.any?(string_keys(), &(&1 == skey))
  end

  @doc """
  A comspec holds a struct with configuration specs for a Commanded context.

  The comspecs are defined in `config/comspecs/*.exs`.
  """
  def kw_data(key) do
    Application.get_env(:comspecs, to_module(key))
  end

  @doc """
  Generate struct with validation checks.
  """
  def struct_data(key) do
    if valid?(key) do
      {:ok, struct!(key)}
    else
      {:error}
    end
  end

  @doc """
  A comspec holds a struct with configuration specs for a Commanded context.

  The comspecs are defined in `config/comspecs/*.exs`.
  """
  def struct_data!(key) do
    skey = to_string(key)
    kw_data(skey)
    |> Enum.reduce(%Comspec{}, fn({key, val}, acc) -> Map.put(acc, key, val) end)
    |> Map.put(:spec_key, key)
  end

  @doc """
  Check comspec validity
  """
  def valid?(_key) do
    true
  end

  @doc """
  Return a table containing the comspec key and shortdoc.

  For use in mix-task help messages.
  """
  def help_table_data do
    string_keys()
    |> Enum.map(&[&1, kw_data(&1)[:spec_shortdoc]])
  end

  defp to_module(input) when is_atom(input) do
    input
  end

  defp to_module(input) do
    base = String.replace(input, ~r/Elixir./, "")
    String.to_atom("Elixir.#{base}")
  end
end
