defmodule Manabot.Command do
  alias Nostrum.Api
  import Nostrum.Struct.Embed

  @days """
  Monday:
  Tuesday:
  Wednesday:
  Thursday:
  Friday:
  Saturday:
  Sunday:
  """

  @hours """
  Closed
  16:00 - 00:00
  16:00 - 00:00
  16:00 - 00:00
  16:00 - 02:00
  10:00 - 02:00
  10:00 - 22:00
  """

  def handle(msg) do
    cond do
      msg.content == "!!ping" ->
        Api.create_message(msg.channel_id, "pong")

      String.contains?(String.downcase(msg.content), "opening hours") ->
        openinghours(msg)

      String.contains?(String.downcase(msg.content), "öffnungs") ->
        openinghours(msg)

      String.contains?(String.downcase(msg.content), "öffnigs") ->
        openinghours(msg)

      true ->
        :ignore
    end
  end

  def openinghours(msg) do
    embedmsg =
      %Nostrum.Struct.Embed{}
      |> put_title("Opening hours")
      |> put_field("Days", @days, true)
      |> put_field("Hours", @hours, true)

    Api.create_message(msg.channel_id, embed: embedmsg)
  end
end
