defmodule PhoneFinder.PhonesTest do
  use PhoneFinder.DataCase

  alias PhoneFinder.Phones

  describe "phone_records" do
    alias PhoneFinder.Phones.PhoneRecord

    import PhoneFinder.PhonesFixtures

    @invalid_attrs %{name: nil}

    test "list_phone_records/0 returns all phone_records" do
      phone_record = phone_record_fixture()
      assert Phones.list_phone_records() == [phone_record]
    end

    test "get_phone_record!/1 returns the phone_record with given id" do
      phone_record = phone_record_fixture()
      assert Phones.get_phone_record!(phone_record.id) == phone_record
    end

    test "create_phone_record/1 with valid data creates a phone_record" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %PhoneRecord{} = phone_record} = Phones.create_phone_record(valid_attrs)
      assert phone_record.name == "some name"
    end

    test "create_phone_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Phones.create_phone_record(@invalid_attrs)
    end

    test "update_phone_record/2 with valid data updates the phone_record" do
      phone_record = phone_record_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %PhoneRecord{} = phone_record} = Phones.update_phone_record(phone_record, update_attrs)
      assert phone_record.name == "some updated name"
    end

    test "update_phone_record/2 with invalid data returns error changeset" do
      phone_record = phone_record_fixture()
      assert {:error, %Ecto.Changeset{}} = Phones.update_phone_record(phone_record, @invalid_attrs)
      assert phone_record == Phones.get_phone_record!(phone_record.id)
    end

    test "delete_phone_record/1 deletes the phone_record" do
      phone_record = phone_record_fixture()
      assert {:ok, %PhoneRecord{}} = Phones.delete_phone_record(phone_record)
      assert_raise Ecto.NoResultsError, fn -> Phones.get_phone_record!(phone_record.id) end
    end

    test "change_phone_record/1 returns a phone_record changeset" do
      phone_record = phone_record_fixture()
      assert %Ecto.Changeset{} = Phones.change_phone_record(phone_record)
    end
  end
end
