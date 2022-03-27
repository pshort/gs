defmodule GlideSlope.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :decimal
    field :currency, :string
    field :import_date, :utc_datetime
    field :text, :string
    field :transaction_date, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :currency, :text, :transaction_date, :import_date])
    |> validate_required([:amount, :currency, :text, :transaction_date, :import_date])
  end
end
