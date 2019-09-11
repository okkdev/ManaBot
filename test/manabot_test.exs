defmodule ManabotTest do
  use ExUnit.Case
  doctest Manabot

  test "greets the world" do
    assert Manabot.hello() == :world
  end
end
