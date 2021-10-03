defmodule PhoneFinder.PhonesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoneFinder.Phones` context.
  """

  @doc """
  Generate a phone_record.
  """
  def phone_record_fixture(attrs \\ %{}) do
    {:ok, phone_record} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> PhoneFinder.Phones.create_phone_record()

    phone_record
  end
end
