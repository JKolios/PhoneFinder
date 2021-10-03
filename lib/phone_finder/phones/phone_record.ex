defmodule PhoneFinder.Phones.PhoneRecord do
  use Ecto.Schema
  import Ecto.Changeset

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

  @doc false
  def changeset(phone_record, attrs) do
    phone_record
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
