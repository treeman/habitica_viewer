# HabiticaViewer

Command line interface for <https://habitica.com/>.

Create config/config.secret.exs and fill in api keys.

API description: <https://habitica.com/apidoc/>

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `habitica_viewer` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:habitica_viewer, "~> 0.1.0"}]
    end
    ```

  2. Ensure `habitica_viewer` is started before your application:

    ```elixir
    def application do
      [applications: [:habitica_viewer]]
    end
    ```

