defmodule PhoneFinder.Phones do
  @moduledoc """
  The Phones context.
  """

  import Ecto.Query, warn: false
  alias PhoneFinder.Repo

  alias PhoneFinder.Phones.PhoneRecord

  @doc """
  Returns the list of phone_records.

  ## Examples

      iex> list_phone_records()
      [%PhoneRecord{}, ...]

  """
  def list_phone_records do
    Repo.all(PhoneRecord)
  end

  @doc """
  Gets a single phone_record.

  Raises `Ecto.NoResultsError` if the Phone record does not exist.

  ## Examples

      iex> get_phone_record!(123)
      %PhoneRecord{}

      iex> get_phone_record!(456)
      ** (Ecto.NoResultsError)

  """
  def get_phone_record!(id), do: Repo.get!(PhoneRecord, id)

  @doc """
  Creates a phone_record.

  ## Examples

      iex> create_phone_record(%{field: value})
      {:ok, %PhoneRecord{}}

      iex> create_phone_record(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_phone_record(attrs \\ %{}) do
    %PhoneRecord{}
    |> PhoneRecord.changeset(attrs)
    |> Repo.insert()
  end

  @spec search_phone_records(any) :: any
  def search_phone_records(term) do
    terms =
      term
      |> String.split(~r/ +/, trim: true) # split on and remove all extra whitespace
      |> Enum.map(fn value -> "%" <> value <> "%" end)

      conditions =
        terms
        |> Enum.reduce(false, fn v, acc_query ->
          dynamic(
            [t],
            ilike(t.first_name, ^v)
            or ilike(t.last_name, ^v)
            or ilike(t.phone_number, ^v)
            or ^acc_query
          )
        end)

    Repo.all(from p in PhoneRecord, where: ^conditions, limit: 20)
  end

  @doc """
  Updates a phone_record.

  ## Examples

      iex> update_phone_record(phone_record, %{field: new_value})
      {:ok, %PhoneRecord{}}

      iex> update_phone_record(phone_record, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_phone_record(%PhoneRecord{} = phone_record, attrs) do
    phone_record
    |> PhoneRecord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a phone_record.

  ## Examples

      iex> delete_phone_record(phone_record)
      {:ok, %PhoneRecord{}}

      iex> delete_phone_record(phone_record)
      {:error, %Ecto.Changeset{}}

  """
  def delete_phone_record(%PhoneRecord{} = phone_record) do
    Repo.delete(phone_record)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking phone_record changes.

  ## Examples

      iex> change_phone_record(phone_record)
      %Ecto.Changeset{data: %PhoneRecord{}}

  """
  def change_phone_record(%PhoneRecord{} = phone_record, attrs \\ %{}) do
    PhoneRecord.changeset(phone_record, attrs)
  end
end
