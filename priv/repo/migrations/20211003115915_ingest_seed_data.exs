defmodule PhoneFinder.Repo.Migrations.IngestSeedData do
  use Ecto.Migration

  def change do
    {:ok, seed_file_contents} = File.read("seed_data.txt")
    seed_file_rows = String.split(seed_file_contents, "\n", trim: true)
    seed_records = Enum.map(seed_file_rows, fn record -> String.split(record, ":") end)
    Enum.map(seed_records,
    fn record ->
      %PhoneFinder.Phones.PhoneRecord{
        phone_number: Enum.at(record, 0),
        first_name: Enum.at(record, 2),
        last_name: Enum.at(record, 3),
        gender: Enum.at(record, 4),
        location_current: Enum.at(record, 5),
        location_born_in: Enum.at(record, 6),
        relationship_status: Enum.at(record, 7),
        employer: Enum.at(record, 8)
      } |> PhoneFinder.Repo.insert
    end
  )
  end
end
