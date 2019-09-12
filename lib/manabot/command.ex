defmodule Manabot.Command do
  @moduledoc """
  The code in this module sucks and it hurts
  """

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

  @tage """
  Montag:
  Dienstag:
  Mittwoch:
  Donnerstag:
  Freitag:
  Samstag:
  Sonntag:
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

  @stunden """
  Geschlossen
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
        openinghours(msg, "en")

      String.contains?(String.downcase(msg.content), "öffnungs") ->
        openinghours(msg, "de")

      String.contains?(String.downcase(msg.content), "öffnigs") ->
        openinghours(msg, "de")

      true ->
        :ignore
    end
  end

  def openinghours(msg, lang) do
    case lang do
      "en" ->
        embedmsg =
          %Nostrum.Struct.Embed{}
          |> put_title("Opening hours")
          |> put_field("Days", @days, true)
          |> put_field("Hours", @hours, true)

        Api.create_message(msg.channel_id, embed: embedmsg)

      "de" ->
        embedmsg =
          %Nostrum.Struct.Embed{}
          |> put_title("Öffnungszeiten")
          |> put_field("Tage", @tage, true)
          |> put_field("Zeiten", @stunden, true)

        Api.create_message(msg.channel_id, embed: embedmsg)
    end
  end
end
