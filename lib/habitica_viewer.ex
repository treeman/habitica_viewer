defmodule HabiticaViewer do
  import Habitica.Task
  alias Habitica.Daily

  def output_response() do
    resp = Habitica.get("tasks/user")

    {:ok, file} = File.open("tasks", [:write, :utf8])
    IO.puts(file, resp.body)
  end

  def run() do
    # FIXME save response as a file while testing.
    # FIXME create tests.

    {:ok, file} = File.open("tasks", [:read, :utf8])
    body = IO.read(file, :all)

    tasks = body
           |> Poison.Parser.parse!()
           |> tasks_from_json

    for t <- tasks do
      case t do
        x -> dump(x)
      end
    end

    :ok
  end
end

