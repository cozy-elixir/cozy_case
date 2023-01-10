defmodule CozyCase do
  @moduledoc """
  Convert data between common naming conventions, such as snake case, kebab case, camel case and
  pascal case.

  Currently, this module provides these main functions:

  + `snake_case/1`
  + `kebab_case/1`
  + `camel_case/1`
  + `pascal_case/1`

  ## Common naming conventions

  | name        | example           |
  | ----------- | ----------------- |
  | snake case  | `welcome_message` |
  | kebab case  | `welcome-message` |
  | camel case  | `welcomeMessage`  |
  | pascal case | `WelcomeMessage`  |

  Read [Naming convention - Examples of multiple-word identifier formats](https://en.wikipedia.org/w/index.php?title=Naming_convention_(programming)&oldid=1126175049#Examples_of_multiple-word_identifier_formats) for more multiple-word identifier formats.

  ## Examples

  All these functions have the same intefaces.

  For strings or atoms, these functions convert them directly:

      iex> CozyCase.snake_case("HelloWorld")
      "hello_world"

      iex> CozyCase.snake_case(HelloWorld)
      "hello_world"

  For maps, there functions convert the keys of maps recursively, without touching the values
  of maps:

      iex> CozyCase.snake_case(%{
      iex>   "FamilyMembers" => [
      iex>     %{
      iex>       "Name" => "Lily",
      iex>       "Age" => 50,
      iex>       "Hobbies" => ["Dreaming", "Singing"]
      iex>     },
      iex>     %{
      iex>       "Name" => "Charlie",
      iex>       "Age" => 55,
      iex>       "Hobbies" => ["Dreaming", "Singing"]
      iex>     }
      iex>   ]
      iex> })
      %{
        "family_members" => [
          %{"name" => "Lily", "age" => 50, "hobbies" => ["Dreaming", "Singing"]},
          %{"name" => "Charlie", "age" => 55, "hobbies" => ["Dreaming", "Singing"]}
        ]
      }

  For lists, these functions convert the keys of maps in lists recursively:

      iex> CozyCase.snake_case([
      iex>     %{
      iex>       "Name" => "Lily",
      iex>       "Age" => 50,
      iex>       "Hobbies" => ["Dreaming", "Singing"]
      iex>     },
      iex>     %{
      iex>       "Name" => "Charlie",
      iex>       "Age" => 55,
      iex>       "Hobbies" => ["Dreaming", "Singing"]
      iex>     }
      iex>   ])
      [
        %{"name" => "Lily", "age" => 50, "hobbies" => ["Dreaming", "Singing"]},
        %{"name" => "Charlie", "age" => 55, "hobbies" => ["Dreaming", "Singing"]}
      ]

  """

  alias CozyCase.SnakeCase
  alias CozyCase.KebabCase
  alias CozyCase.CamelCase
  alias CozyCase.PascalCase

  def snake_case(term) when is_binary(term) or is_atom(term), do: convert_plain(term, &SnakeCase.convert/1)
  def snake_case(term) when is_map(term) or is_list(term), do: convert_nest(term, &SnakeCase.convert/1)

  def kebab_case(term) when is_binary(term) or is_atom(term), do: convert_plain(term, &KebabCase.convert/1)
  def kebab_case(term) when is_map(term) or is_list(term), do: convert_nest(term, &KebabCase.convert/1)

  def camel_case(term) when is_binary(term) or is_atom(term), do: convert_plain(term, &CamelCase.convert/1)
  def camel_case(term) when is_map(term) or is_list(term), do: convert_nest(term, &CamelCase.convert/1)

  def pascal_case(term) when is_binary(term) or is_atom(term), do: convert_plain(term, &PascalCase.convert/1)
  def pascal_case(term) when is_map(term) or is_list(term), do: convert_nest(term, &PascalCase.convert/1)

  defp convert_plain(string, fun) when is_binary(string) do
    fun.(string)
  end

  defp convert_plain(atom, fun) when is_atom(atom) do
    Atom.to_string(atom)
    |> case do
      "Elixir." <> rest -> rest
      string -> string
    end
    |> fun.()
  end

  defp convert_plain(any, _fun), do: any

  defp convert_nest(map, fun) when is_map(map) do
    try do
      for {k, v} <- map,
          into: %{},
          do: {convert_plain(k, fun), convert_nest(v, fun)}
    rescue
      # not Enumerable
      Protocol.UndefinedError -> map
    end
  end

  defp convert_nest(list, fun) when is_list(list) do
    Enum.map(list, &convert_nest(&1, fun))
  end

  defp convert_nest(any, _fun), do: any
end
