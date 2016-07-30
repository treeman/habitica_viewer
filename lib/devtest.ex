defmodule DevTest do
  import Habitica.Parser

  def output_response(path, file) do
    resp = Habitica.get(path)

    {:ok, file} = File.open(file, [:write, :utf8])
    IO.puts(file, resp.body)
  end

  def run(file) do
    {:ok, file} = File.open(file, [:read, :utf8])
    body = IO.read(file, :all)

    tasks = body |> parse_user_tasks
    IO.inspect(tasks)

    :ok
  end
end

