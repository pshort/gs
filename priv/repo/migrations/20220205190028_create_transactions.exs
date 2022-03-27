defmodule GlideSlope.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :decimal
      add :currency, :string
      add :text, :text
      add :transaction_date, :utc_datetime
      add :import_date, :utc_datetime

      timestamps()
    end
  end
end
