defmodule HabiticaViewer do
  alias Habitica.Daily

  def main(args) do
    args |> parse_args |> run
  end

  def parse_args(args) do
    options = OptionParser.parse(args,
      strict: [help: :boolean,
               conky: :boolean],
      aliases: [h: :help])

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
    for x <- Habitica.user_dailies do
      print x, opts
    end
  end
  def run([:todos, opts]) do
    for x <- Habitica.user_todos do
      print x, opts
    end
  end
  def run([:habits, opts]) do
    for x <- Habitica.user_habits do
      print x, opts
    end
  end

  def print(task, opts \\ %{})
  def print(%Daily{} = daily, opts) do
    if Keyword.has_key?(opts, :conky) do
      IO.write("${voffset 8}")
      IO.write("${color #{daily_color(daily)}}")
      IO.puts(daily.text)
    else
      due? = daily.due_today? and !daily.completed?
      IO.puts("#{daily.text} #{if due? do " (due)" end}")
    end
  end

  def print(task, opts) do
    if Keyword.has_key?(opts, :conky) do
      IO.write("${voffset 8}")
      IO.write("${color #ebdbb2}")
      IO.puts(task.text)
    else
      IO.puts(task.text)
    end
  end

  def daily_color(daily) do
    cond do
      daily.completed? -> "#F291E0"
      daily.due_today? -> "#ebdbb2"
      true -> "#808080"
    end
  end
end

