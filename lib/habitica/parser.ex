defmodule Habitica.Parser do
  alias Habitica.Daily
  alias Habitica.Habit
  alias Habitica.Reward
  alias Habitica.Todo

  def parse_user_tasks(body) do
    json_body = Poison.Parser.parse!(body)

    json_body["data"]
    |> Enum.map(&task_from_json/1)
    |> Enum.filter(fn nil -> false
                      t -> !String.starts_with?(t.text, "#")
                   end)
  end

  defp task_from_json(json_task) do
    from_json(json_task["type"], json_task)
  end

  defp remove_emoji(text) do
    text
    |> String.replace(~r|:[^:]+:|, "")
    |> String.trim
  end

  defp from_json("daily", json) do
    due_today? = case json["frequency"] do
      "weekly" ->
        repeat_due_today(json["repeat"])
      _ ->
        # FIXME need to handle other repeat.
        false
    end

    %Daily{
      attribute: attribute_from_json(json["attribute"]),
      completed?: json["completed"],
      due_today?: due_today?,
      checklist: json["checklist"],
      text: remove_emoji(json["text"])
    }
  end
  defp from_json("habit", json) do
    %Habit{
      attribute: attribute_from_json(json["attribute"]),
      text: remove_emoji(json["text"])
    }
  end
  defp from_json("reward", json) do
    %Reward{
      attribute: attribute_from_json(json["attribute"]),
      text: remove_emoji(json["text"]),
      cost: json["value"]
    }
  end
  defp from_json("todo", json) do
    %Todo{
      attribute: attribute_from_json(json["attribute"]),
      completed?: json["completed"],
      checklist: json["checklist"],
      text: remove_emoji(json["text"])
    }
  end

  defp repeat_due_today(repeat) do
    {_, index2weekday} =
      ["m", "t", "w", "th", "f", "s", "su"]
      |> Enum.reduce({1, %{}}, fn(x, {i, map}) -> {i + 1, Map.put(map, i, x)} end)
    {date, _} = :calendar.local_time()
    weekday_index = :calendar.day_of_the_week(date)
    # Repeat has a map of "m" => true/false, this simply indexes today
    repeat[index2weekday[weekday_index]]
  end

  defp attribute_from_json("int"), do: :intelligence
  defp attribute_from_json("str"), do: :strength
  defp attribute_from_json("per"), do: :perception
  defp attribute_from_json("con"), do: :constitution
end

