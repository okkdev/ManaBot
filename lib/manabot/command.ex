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
  17:00 - 23:30
  17:00 - 23:30
  17:00 - 23:30
  17:00 - 01:00
  14:00 - 01:00
  14:00 - 22:00
  """

  @stunden """
  Geschlossen
  17:00 - 23:30
  17:00 - 23:30
  17:00 - 23:30
  17:00 - 01:00
  14:00 - 01:00
  14:00 - 22:00
  """

  def handle(msg) do
    content = String.downcase(msg.content)

    cond do
      msg.content == "!!ping" ->
        Api.create_message(msg.channel_id, "pyongyang")

      String.contains?(content, "opening hours") ->
        openinghours(msg, :en)

      String.contains?(content, "öffnungs") ->
        openinghours(msg, :de)

      String.contains?(content, "öffnigs") ->
        openinghours(msg, :de)

      true ->
        :ignore
    end
  end

  def openinghours(msg, lang) do
    embedmsg =
      case lang do
        :en ->
          %Nostrum.Struct.Embed{}
          |> put_title("Opening hours")
          |> put_field("Days", @days, true)
          |> put_field("Hours", @hours, true)

        :de ->
          %Nostrum.Struct.Embed{}
          |> put_title("Öffnungszeiten")
          |> put_field("Tage", @tage, true)
          |> put_field("Zeiten", @stunden, true)
      end

    Api.create_message(msg.channel_id, embed: embedmsg)
  end
end
