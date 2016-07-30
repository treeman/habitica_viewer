# Just manual testing from a cache.
defmodule DevTest do
  import Habitica.Parser

  def cache_path(path, file) do
    resp = Habitica.get(path)

    {:ok, file} = File.open("cache/" <> file, [:write, :utf8])
    IO.puts(file, resp.body)
  end

  def read_file(file) do
    {:ok, file} = File.open(file, [:read, :utf8])
    IO.read(file, :all)
  end

  def run(:dailies) do
    parse_tasks("cache/dailies")
  end
  def run(:todos) do
    parse_tasks("cache/todos")
  end
  def run(:habits) do
    parse_tasks("cache/habits")
  end

  def parse_tasks(file) do
    opts = [conky: true]
    tasks = file |> read_file |> parse_user_tasks
    for task <- tasks do
      HabiticaViewer.print(task, opts)
    end
    #IO.inspect(tasks)
    :ok
  end
end

