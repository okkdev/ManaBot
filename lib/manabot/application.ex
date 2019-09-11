defmodule Manabot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    Manabot.Supervisor.start_link
  end
end
