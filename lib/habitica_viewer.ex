defmodule HabiticaViewer do
  import Habitica

  def main(args) do
    args |> parse_args |> run
  end

  def parse_args(args) do
    options = OptionParser.parse(args,
      strict: [help: :boolean, conky: :boolean],
      aliases: [h: :help])

    IO.inspect(options)
    case options do
      {[help: true], _, _} -> :help
      {_, ["help"], _} -> :help
      {opts, ["dailies"], _} -> [:dailies, opts]
      {opts, "habits", _} -> [:habits, opts]
      {opts, "todos", _} -> [:todos, opts]
      _ -> :help
    end
  end

  def run(:help) do
    IO.puts """
    Habitica viewer

    Usage:
      habitica_viewer todos [options]
      habitica_viewer dailies [options]
      habitica_viewer habits [options]
      habitica_viewer (-h | --help)

    Options:
      -h --help     Display this message
      --conky       Add format specifiers for conky display. Harr.
    """
  end

  def run([:dailies, opts]) do
    IO.puts("listing dailys")
  end
  def run([:todos, opts]) do
    IO.puts("listing todos")
  end
  def run([:habits, opts]) do
    IO.puts("listing habits")
  end
end

