defmodule Manabot.Supervisor do
  def start_link do
    children = [Manabot.Consumer]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
