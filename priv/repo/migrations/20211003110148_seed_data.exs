defmodule PhoneFinder.Repo.Migrations.SeedData do
  use Ecto.Migration

  def change do
    create table(:phone_records) do
      add :phone_number, :string
      add :first_name, :string
      add :last_name, :string
      add :gender, :string
      add :location_current, :string
      add :location_born_in, :string
      add :relationship_status, :string
      add :employer, :string
    end

    execute "CREATE extension if not exists pg_trgm;"
    execute "CREATE INDEX full_name_trgm_index ON phone_records USING gin ((first_name || ' ' || last_name) gin_trgm_ops);"
    execute "CREATE INDEX phone_number_trgm_index ON phone_records USING gin (phone_number gin_trgm_ops);"
  end
end
