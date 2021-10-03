defmodule PhoneFinderWeb.PhoneRecordController do
  use PhoneFinderWeb, :controller

  require Logger

  alias PhoneFinder.Phones
  alias PhoneFinder.Phones.PhoneRecord

  def index(conn, _params) do
    phone_records = Phones.list_phone_records()
    render(conn, "index.html", phone_records: phone_records)
  end

  def new(conn, _params) do
    changeset = Phones.change_phone_record(%PhoneRecord{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"phone_record" => phone_record_params}) do
    case Phones.create_phone_record(phone_record_params) do
      {:ok, phone_record} ->
        conn
        |> put_flash(:info, "Phone record created successfully.")
        |> redirect(to: Routes.phone_record_path(conn, :show, phone_record))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    phone_record = Phones.get_phone_record!(id)
    render(conn, "show.html", phone_record: phone_record)
  end

  def search(conn, %{"params" => %{"search_term" => term}}) do
    Logger.debug "Search called with term: #{term}"
    search_results = Phones.search_phone_records(term)
    render(conn, "search.html", search_results: search_results)
  end

  def search(conn, %{}) do
    Logger.debug "Empty search called"
    render(conn, "search.html", search_results: %{})
  end

  def edit(conn, %{"id" => id}) do
    phone_record = Phones.get_phone_record!(id)
    changeset = Phones.change_phone_record(phone_record)
    render(conn, "edit.html", phone_record: phone_record, changeset: changeset)
  end

  def update(conn, %{"id" => id, "phone_record" => phone_record_params}) do
    phone_record = Phones.get_phone_record!(id)

    case Phones.update_phone_record(phone_record, phone_record_params) do
      {:ok, phone_record} ->
        conn
        |> put_flash(:info, "Phone record updated successfully.")
        |> redirect(to: Routes.phone_record_path(conn, :show, phone_record))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", phone_record: phone_record, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    phone_record = Phones.get_phone_record!(id)
    {:ok, _phone_record} = Phones.delete_phone_record(phone_record)

    conn
    |> put_flash(:info, "Phone record deleted successfully.")
    |> redirect(to: Routes.phone_record_path(conn, :index))
  end
end
