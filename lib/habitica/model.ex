defmodule Habitica.Daily do
  defstruct ([:attribute,
              :completed?,
              :checklist,
              :due_today?,
              :text])
end

defmodule Habitica.Habit do
  defstruct ([:attribute,
              :text])
end

defmodule Habitica.Reward do
  defstruct ([:attribute,
              :text,
              :cost])
end

defmodule Habitica.Todo do
  defstruct ([:attribute,
              :completed?,
              :checklist,
              :text])
end

