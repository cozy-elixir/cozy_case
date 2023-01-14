defmodule CozyCase.SnakeCase do
  @moduledoc false

  @doc false
  def convert(string) when is_binary(string) do
    string
    |> String.replace(~r/([A-Z]+)([A-Z][a-z])/, "\\1_\\2")
    |> String.replace(~r/([a-z\d])([A-Z])/, "\\1_\\2")
    |> String.replace(~r/-/, "_")
    |> String.downcase()
  end
end
