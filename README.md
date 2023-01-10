# CozyCase

> Convert data between common naming conventions, such as snake case, kebab case, camel case and pascal case.

## Installation

Add `cozy_case` to the list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cozy_case, "~> 0.1.0"}
  ]
end
```

## Usage

For more information, see the [documentation](https://hexdocs.pm/cozy_case).

## Common naming conventions

| name        | example           |
| ----------- | ----------------- |
| snake case  | `welcome_message` |
| kebab case  | `welcome-message` |
| camel case  | `welcomeMessage`  |
| pascal case | `WelcomeMessage`  |

Read [Naming convention - Examples of multiple-word identifier formats](<https://en.wikipedia.org/w/index.php?title=Naming_convention_(programming)&oldid=1126175049#Examples_of_multiple-word_identifier_formats>) for more multiple-word identifier formats.

## Acknowledgments

This repo is forked from [johnnyji/proper_case](https://github.com/johnnyji/proper_case), but only provides core functions for conversion.

## License

Apache License 2.0
