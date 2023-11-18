defmodule CozyCase do
  @moduledoc ~S"""
  Converts data between common multiple-word identifier formats, such as snake case, kebab case,
  camel case and pascal case.

  Currently, this module provides these main functions:

  + `snake_case/1`
  + `kebab_case/1`
  + `camel_case/1`
  + `pascal_case/1`

  ## Multiple-word identifier formats

  | name        | example           |
  | ----------- | ----------------- |
  | snake case  | `welcome_message` |
  | kebab case  | `welcome-message` |
  | camel case  | `welcomeMessage`  |
  | pascal case | `WelcomeMessage`  |

  > Read [Examples of multiple-word identifier formats](https://en.wikipedia.org/w/index.php?title=Naming_convention_(programming)&oldid=1126175049#Examples_of_multiple-word_identifier_formats) for more unsupported formats.

  ## Examples

  All these functions have the same intefaces.

  For strings or atoms, these functions convert them directly:

      iex> CozyCase.snake_case("HelloWorld")
      "hello_world"

      iex> CozyCase.snake_case(HelloWorld)
      "hello_world"

  For maps, these functions convert the keys of maps recursively, without touching the values
  of maps:

      iex> CozyCase.snake_case(%{
      ...>   "FamilyMembers" => [
      ...>     %{
      ...>       "Name" => "Lily",
      ...>       "Age" => 50,
      ...>       "Hobbies" => ["Dreaming", "Singing"]
      ...>     },
      ...>     %{
      ...>       "Name" => "Charlie",
      ...>       "Age" => 55,
      ...>       "Hobbies" => ["Dreaming", "Singing"]
      ...>     }
      ...>   ]
      ...> })
      %{
        "family_members" => [
          %{"name" => "Lily", "age" => 50, "hobbies" => ["Dreaming", "Singing"]},
          %{"name" => "Charlie", "age" => 55, "hobbies" => ["Dreaming", "Singing"]}
        ]
      }

  For lists, these functions convert the keys of maps in lists recursively:

      iex> CozyCase.snake_case([
      ...>     %{
      ...>       "Name" => "Lily",
      ...>       "Age" => 50,
      ...>       "Hobbies" => ["Dreaming", "Singing"]
      ...>     },
      ...>     %{
      ...>       "Name" => "Charlie",
      ...>       "Age" => 55,
      ...>       "Hobbies" => ["Dreaming", "Singing"]
      ...>     }
      ...>   ])
      [
        %{"name" => "Lily", "age" => 50, "hobbies" => ["Dreaming", "Singing"]},
        %{"name" => "Charlie", "age" => 55, "hobbies" => ["Dreaming", "Singing"]}
      ]

  ## Integrate with other packages

  `CozyCase` doesn't provide higher-level wrappers. Because everything is a function, it's very
  easy to integrate `CozyCase` with other packages.

  ### [`plug`](https://hexdocs.pm/plug)

  Converts params in `%Plug.Conn{}` to snake case:

      defmodule DemoWeb.Plug.SnakeCaseParams do
        @behaviour Plug

        @impl true
        def init(opts), do: opts

        @impl true
        def call(%{params: params} = conn, _opts) do
          %{conn | params: CozyCase.snake_case(params)}
        end
      end

  ### [`jason`](https://hexdocs.pm/jason)

  Decode a JSON string:

      iex> json = "{\"Age\":23,\"FamilyMembers\":[],\"Name\":\"Lenna\"}"
      iex> Jason.decode!(json, keys: &CozyCase.snake_case/1)
      %{"name" => "Lenna", "age" => 23, "family_members" => []}

  Encode a map as a JSON string:

      iex> map = %{"name" => "Lenna", "age" => 23, "family_members" => []}
      iex> map |> CozyCase.camel_case() |> Jason.encode!()
      "{\"age\":23,\"familyMembers\":[],\"name\":\"Lenna\"}"

  ## Note

  `CozyCase` is created for the convertion between common multiple-word identifier formats.

  Because of that, `CozyCase` doesn't handle spaces which are not used as part of indentifier.

  As the user of `CozyCase`, you should NOT pass string containing spaces, or the result will be
  surprising.

      iex> CozyCase.snake_case("welCome Message")
      "wel_come message"

      iex> CozyCase.kebab_case("wel_Come Me_ssage")
      "wel-come me-ssage"

  """

  alias CozyCase.SnakeCase
  alias CozyCase.KebabCase
  alias CozyCase.CamelCase
  alias CozyCase.PascalCase

  @doc """
  Converts other supported cases to snake case.
  """
  @spec snake_case(String.t() | atom()) :: String.t()
  @spec snake_case(t) :: t when t: map() | list()
  def snake_case(term) when is_binary(term) or is_atom(term), do: convert_plain(term, SnakeCase)
  def snake_case(term) when is_map(term) or is_list(term), do: convert_nest(term, SnakeCase)

  @doc """
  Converts other supported cases to kebab case.
  """
  @spec kebab_case(String.t() | atom()) :: String.t()
  @spec kebab_case(t) :: t when t: map() | list()
  def kebab_case(term) when is_binary(term) or is_atom(term), do: convert_plain(term, KebabCase)
  def kebab_case(term) when is_map(term) or is_list(term), do: convert_nest(term, KebabCase)

  @doc """
  Converts other supported cases to camel case.
  """
  @spec camel_case(String.t() | atom()) :: String.t()
  @spec camel_case(t) :: t when t: map() | list()
  def camel_case(term) when is_binary(term) or is_atom(term), do: convert_plain(term, CamelCase)
  def camel_case(term) when is_map(term) or is_list(term), do: convert_nest(term, CamelCase)

  @doc """
  Converts other supported cases to pascal case.
  """
  @spec pascal_case(String.t() | atom()) :: String.t()
  @spec pascal_case(t) :: t when t: map() | list()
  def pascal_case(term) when is_binary(term) or is_atom(term), do: convert_plain(term, PascalCase)
  def pascal_case(term) when is_map(term) or is_list(term), do: convert_nest(term, PascalCase)

  defp convert_plain(string, module) when is_binary(string), do: module.convert(string)

  defp convert_plain(atom, module) when is_atom(atom) do
    Atom.to_string(atom)
    |> case do
      "Elixir." <> rest -> rest
      string -> string
    end
    |> module.convert()
  end

  defp convert_plain(any, _module), do: any

  defp convert_nest(map, module) when is_map(map) do
    try do
      for {k, v} <- map,
          into: %{},
          do: {convert_plain(k, module), convert_nest(v, module)}
    rescue
      # not Enumerable
      Protocol.UndefinedError -> map
    end
  end

  defp convert_nest(list, module) when is_list(list), do: Enum.map(list, &convert_nest(&1, module))

  defp convert_nest(any, _module), do: any
end
