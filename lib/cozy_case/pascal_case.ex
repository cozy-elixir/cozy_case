defmodule CozyCase.PascalCase do
  @moduledoc false

  @split_regex ~r/(?:^|[-_])|(?=[A-Z][a-z])/

  def convert(string) when is_binary(string) do
    string
    |> then(&Regex.split(@split_regex, &1))
    |> Enum.filter(&(&1 != ""))
    |> pascalize_list()
    |> Enum.join()
  end

  defp pascalize_list([]), do: []

  defp pascalize_list([h | tail]) do
    [capitalize(h)] ++ pascalize_list(tail)
  end

  def capitalize(word), do: String.capitalize(word)
end
