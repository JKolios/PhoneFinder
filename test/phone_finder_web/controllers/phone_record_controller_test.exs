defmodule PhoneFinderWeb.PhoneRecordControllerTest do
  use PhoneFinderWeb.ConnCase

  import PhoneFinder.PhonesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all phone_records", %{conn: conn} do
      conn = get(conn, Routes.phone_record_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Phone records"
    end
  end

  describe "new phone_record" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.phone_record_path(conn, :new))
      assert html_response(conn, 200) =~ "New Phone record"
    end
  end

  describe "create phone_record" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.phone_record_path(conn, :create), phone_record: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.phone_record_path(conn, :show, id)

      conn = get(conn, Routes.phone_record_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Phone record"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.phone_record_path(conn, :create), phone_record: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Phone record"
    end
  end

  describe "edit phone_record" do
    setup [:create_phone_record]

    test "renders form for editing chosen phone_record", %{conn: conn, phone_record: phone_record} do
      conn = get(conn, Routes.phone_record_path(conn, :edit, phone_record))
      assert html_response(conn, 200) =~ "Edit Phone record"
    end
  end

  describe "update phone_record" do
    setup [:create_phone_record]

    test "redirects when data is valid", %{conn: conn, phone_record: phone_record} do
      conn = put(conn, Routes.phone_record_path(conn, :update, phone_record), phone_record: @update_attrs)
      assert redirected_to(conn) == Routes.phone_record_path(conn, :show, phone_record)

      conn = get(conn, Routes.phone_record_path(conn, :show, phone_record))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, phone_record: phone_record} do
      conn = put(conn, Routes.phone_record_path(conn, :update, phone_record), phone_record: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Phone record"
    end
  end

  describe "delete phone_record" do
    setup [:create_phone_record]

    test "deletes chosen phone_record", %{conn: conn, phone_record: phone_record} do
      conn = delete(conn, Routes.phone_record_path(conn, :delete, phone_record))
      assert redirected_to(conn) == Routes.phone_record_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.phone_record_path(conn, :show, phone_record))
      end
    end
  end

  defp create_phone_record(_) do
    phone_record = phone_record_fixture()
    %{phone_record: phone_record}
  end
end
