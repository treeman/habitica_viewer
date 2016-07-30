defmodule HabiticaViewer do
  import Habitica
  alias Habitica.Daily
  alias Habitica.Habit
  alias Habitica.Reward
  alias Habitica.Todo

  def main(args) do
    args |> parse_args |> run
  end

  def parse_args(args) do
    options = OptionParser.parse(args,
      strict: [help: :boolean,
               conky: :boolean],
      aliases: [h: :help])

    IO.inspect(options)
    case options do
      {[help: true], _, _} -> :help
      {_, ["help"], _} -> :help
      {opts, ["dailies"], _} -> [:dailies, opts]
      {opts, ["habits"], _} -> [:habits, opts]
      {opts, ["todos"], _} -> [:todos, opts]
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
      -h --help         Display this message
      --conky           Add format specifiers for conky display. Harr.
    """
  end

  def run([:dailies, opts]) do
    IO.inspect(opts)
    IO.puts("listing dailys")
  end
  def run([:todos, opts]) do
    IO.puts("listing todos")
  end
  def run([:habits, opts]) do
    IO.puts("listing habits")
  end

  def print(task, opts \\ %{})
  def print(%Daily{} = daily, opts) do
    if Keyword.has_key?(opts, :conky) do
      IO.write("${{voffset 8}}")
      IO.write("${{color #{daily_color(daily)}}}")
      IO.puts(daily.text)
    else
      due? = daily.due_today? and !daily.completed?
      IO.puts("#{daily.text} #{if due? do " (due)" end}")
    end
  end

  def print(task, opts) do
    if Keyword.has_key?(opts, :conky) do
      IO.write("${{voffset 8}}")
      IO.puts(task.text)
    else
      IO.puts(task.text)
    do
  end

  def daily_color(daily) do
    cond do
      daily.completed? -> "#ECF0A5"
      daily.due_today? -> "#FFFFFF"
      true -> "#808080"
    end
  end
end

