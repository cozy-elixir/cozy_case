# CozyCase

> Convert data between different naming conventions, such as snake case, kebab case, camel case and pascal case.

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

## Different naming conventions

### snake case

```text
welcome_message = "Hello World"
```

### kebab case

```text
welcome-message = "Hello World"
```

### camel case

```text
welcomeMessage = "Hello World"
```

### pascal case

```text
WelcomeMessage = "Hello World"
```

## Acknowledgments

This repo is forked from [johnnyji/proper_case](https://github.com/johnnyji/proper_case), but only provides core functions for conversion.

## License

Apache License 2.0
