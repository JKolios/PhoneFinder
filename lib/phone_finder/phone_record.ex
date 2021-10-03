defmodule PhoneFinder.PhoneRecord do
  use Ecto.Schema

  schema "phone_records" do
    field :phone_number, :string
    field :first_name, :string
    field :last_name, :string
    field :gender, :string
    field :location_current, :string
    field :location_born_in, :string
    field :relationship_status, :string
    field :employer, :string
  end

  def search(term) do
    PhoneFinder.PhoneRecord |>
    Ecto.Query.from p in PhoneFinder.PhoneRecord, where: ilike("first_name || ' ' || last_name", "%#{term}%") |>
    PhoneFinder.Repo.all
  end
end
