defmodule HabiticaViewer do
  def run() do
    # FIXME save response as a file while testing.
    # FIXME create tests.
    resp = Habitica.get("tasks/user")
    json = resp.body
           |> Poison.Parser.parse!()
    tasks = json.data
  end
end

