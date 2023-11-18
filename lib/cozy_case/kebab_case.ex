defmodule CozyCase.KebabCase do
  @moduledoc false

  @split_regex ~r/(?:^|[-_])|(?<=[a-z\d])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])/

  @doc false
  def convert(string) when is_binary(string) do
    string
    |> then(&Regex.split(@split_regex, &1))
    |> Enum.filter(&(&1 != ""))
    |> kebabize_list()
    |> Enum.join("-")
  end

  defp kebabize_list([]), do: []

  defp kebabize_list([h | tail]) do
    [lowercase(h)] ++ kebabize_list(tail)
  end

  defp lowercase(word), do: String.downcase(word)
end
