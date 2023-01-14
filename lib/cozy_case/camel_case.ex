defmodule CozyCase.CamelCase do
  @moduledoc false

  @split_regex ~r/(?:^|[-_])|(?=[A-Z][a-z])/

  @doc false
  def convert(string) when is_binary(string) do
    string
    |> then(&Regex.split(@split_regex, &1))
    |> Enum.filter(&(&1 != ""))
    |> camelize_list(:init)
    |> Enum.join()
  end

  defp camelize_list([], _), do: []

  defp camelize_list([h | tail], :init) do
    [lowercase(h)] ++ camelize_list(tail, :cont)
  end

  defp camelize_list([h | tail], :cont) do
    [capitalize(h)] ++ camelize_list(tail, :cont)
  end

  defp capitalize(word), do: String.capitalize(word)
  defp lowercase(word), do: String.downcase(word)
end
